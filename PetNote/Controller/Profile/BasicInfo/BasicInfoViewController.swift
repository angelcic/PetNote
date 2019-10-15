//
//  BasicInfoViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class BasicInfoViewController: BaseContainerViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var currentImage: UIImage? 
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: BasicInfoTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: AddImageTableViewCell.self), bundle: nil)
    }
    
    func petDidChange(_ viewController: ContainerViewController) {
        tableView.reloadData()
    }
    
    func showDeletePetVC() {
        guard
            let deletePetVC = UIStoryboard.profile.instantiateViewController(
            withIdentifier: DeletePetViewController.identifier)
            as? DeletePetViewController
        else {
            return
        }
        
        deletePetVC.delegate = self
        
        // 顯示樣式
        deletePetVC.modalPresentationStyle = UIModalPresentationStyle.custom
        deletePetVC.view.backgroundColor = UIColor.clear

        self.present(deletePetVC, animated: false, completion: nil)
        
    }
    
    func showAdjustImageVC(image: UIImage?) {
        guard
            let image = image,
            let adjustImageVC = UIStoryboard.profile.instantiateViewController(
                withIdentifier: AdjustPhotoViewController.identifier
                )
                as? AdjustPhotoViewController
        else {
            return
        }
        
        adjustImageVC.initAdjustPhotoVC(image: image) {[weak self] image in
            
            guard let pet = self?.currentPet else {return}
            let petId = "\(pet.petId)"
            
            // 把照片存入 app 下的資料夾
            LocalFileManager.shared.saveImage(petId: petId,
                                              image: image) { [weak self] result in
                switch result {
                case .success(let path):
                    self?.currentPet?.photo = path
                    StorageManager.shared.saveAll()
                case .failure(let error):
                    print(error)
                }
            }
            
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
        show(adjustImageVC, sender: nil)
    }
}

extension BasicInfoViewController: DeletePetViewControllerDelegate {
    
    func pressConfirmDeleteButton(_ viewController: DeletePetViewController) {
        StorageManager.shared.deleteCurrentPet { result in
            switch result {
            case .success:
                StorageManager.shared.currentPetIndex = 0
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension BasicInfoViewController: AddImageTableViewCellDelegate {
    
    func pressAddImageButton(_ cell: AddImageTableViewCell) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: false, completion: nil)
    }
}

extension BasicInfoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        picker.dismiss(animated: false) { [weak self] in
            let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self?.showAdjustImageVC(image: image)
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil)
    }
}

extension BasicInfoViewController: UINavigationControllerDelegate {
    
}

extension BasicInfoViewController: BasicInfoTableViewCellDelegate {
    
    func pressDeleteButton(_ cell: BasicInfoTableViewCell) {
        showDeletePetVC()
    }
    
    func pressModifyButton(_ cell: BasicInfoTableViewCell) {
        guard
            let modifyInfoVC = UIStoryboard.profile.instantiateViewController(
            withIdentifier: ModifyBaseInfoViewController.identifier)
            as? ModifyBaseInfoViewController
        else {
            return
        }
        
        modifyInfoVC.currentPet = currentPet
        modifyInfoVC.delegate = self
        
        // 顯示樣式
        modifyInfoVC.modalPresentationStyle = UIModalPresentationStyle.custom
        modifyInfoVC.view.backgroundColor = UIColor.clear        
        
        self.present(modifyInfoVC, animated: false, completion: nil)

    }
}

extension BasicInfoViewController: ModifyBaseInfoViewControllerDelegate {
    
    func confirmModify(_ viewControler: ModifyBaseInfoViewController?) {
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
    }
    
}

extension BasicInfoViewController: UITableViewDelegate {
    
}

extension BasicInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: AddImageTableViewCell.identifier,
                    for: indexPath)
                    as? AddImageTableViewCell
            else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.layoutCell(image: currentImage)
            
            if let imagePath = currentPet?.photo {
                let image = LocalFileManager.shared.readImage(fileName: imagePath)
                cell.layoutCell(image: image)
            }
            return cell
       
        default:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: BasicInfoTableViewCell.identifier,
                    for: indexPath)
                    as? BasicInfoTableViewCell
            else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            
            if let pet = currentPet {
                
                let birth = pet.getBirth()
                
                cell.layoutCell(
                    name: pet.name,
                    gender: pet.gender,
                    petType: pet.petType,
                    neuter: pet.neuter,
                    petId: pet.id,
                    birth: birth,
                    breed: pet.breed,
                    color: pet.color
                )
            
            }
            
            return cell
        }
        
    }
    
}
