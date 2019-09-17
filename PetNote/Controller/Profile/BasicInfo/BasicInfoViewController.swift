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
    
    override var currentPet: PNPetInfo? {
        didSet {
            if currentPet != nil {
                addPetAlertLayer.isHidden = true
            } else {
                addPetAlertLayer.isHidden = false
            }
//            tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .none)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
//        
//        if currentPet == nil {
//            addPetAlertLayer.isHidden = false
//        }
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
        
        print("加入照片")
    }
}

extension BasicInfoViewController: BasicInfoTableViewCellDelegate {
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
