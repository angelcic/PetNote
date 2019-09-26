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
    
    @IBOutlet weak var addPetAlertLayer: UIView!
    
    var currentImage: UIImage? 
    
    override var currentPet: PNPetInfo? {
        didSet {
            if currentPet != nil {
                addPetAlertLayer.isHidden = true
            } else {
                addPetAlertLayer.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: BasicInfoTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: AddImageTableViewCell.self), bundle: nil)
    }
    
    func petDidChange() {
        tableView.reloadData()
//        tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .none) // 待研究
    }
}

extension BasicInfoViewController: AddImageTableViewCellDelegate {
    func pressAddImageButton() {
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
        
        picker.dismiss(animated: false, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let pet = currentPet else {return}
            let petId = "\(pet.petId)"
            
            // 把照片存入 app 下的資料夾
            LocalFileManager.shared.saveImage(petId: petId, image: image) { [weak self] result in
                switch result {
                case .success(let path):
                    self?.currentPet?.photo = path
                    StorageManager.shared.saveAll()
                case .failure(let error):
                    print(error)
                }
            }
            
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false, completion: nil)
    }
}

extension BasicInfoViewController: UINavigationControllerDelegate {
    
}

extension BasicInfoViewController: BasicInfoTableViewCellDelegate {
    func pressDeleteButton() {
        StorageManager.shared.deleteCurrentPet { result in
            switch result {
            case .success:
                StorageManager.shared.currentPetIndex = 0
                print("已移除成員")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func pressModifyButton() {
        guard let modifyInfoVC = UIStoryboard.profile.instantiateViewController(
            withIdentifier: ModifyBaseInfoViewController.identifier)
            as? ModifyBaseInfoViewController
            else {return}
        
        // 顯示樣式
        modifyInfoVC.modalPresentationStyle = UIModalPresentationStyle.custom
        
        modifyInfoVC.currentPet = currentPet
        modifyInfoVC.delegate = self
        
        self.present(modifyInfoVC, animated: false, completion: nil)
        
        modifyInfoVC.view.backgroundColor = UIColor.clear

    }
}

extension BasicInfoViewController: ModifyBaseInfoViewControllerDelegate {
    func confirmModify() {
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
                LocalFileManager.shared.readImage(imagePath: imagePath) { result in
                switch result {
                case .success(let image):
                    cell.layoutCell(image: image)
                case .failure(let error):
                    print(error)
                }
                
                }
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
                cell.layoutCell(name: pet.name,
                                gender: pet.gender,
                                petType: pet.petType,
                                petId: pet.id,
                                birth: birth,
                                breed: pet.breed,
                                color: pet.color)
            }
            return cell
        }
        
    }
    
}
