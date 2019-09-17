//
//  ModifyBaseInfoViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/15.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ModifyBaseInfoViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.addCorner(cornerRadius: 30)
            tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var confirmModifyButton: UIButton! {
        didSet {
            confirmModifyButton.addCorner(cornerRadius: 30)
            confirmModifyButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            
        }
    }
    
    var currentPet: PNPetInfo?
    
    var infoCell: ModifyBasicInfoTableViewCell = {
        if let cell = Bundle(for: ModifyBasicInfoTableViewCell.self).loadNibNamed(
            ModifyBasicInfoTableViewCell.identifier,
            owner: nil,
            options: nil)?.first as? ModifyBasicInfoTableViewCell {
            return cell
        } else {
            return ModifyBasicInfoTableViewCell()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: ModifyBasicInfoTableViewCell.identifier, bundle: nil)
    }
    
    @IBAction func closeAction() {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func confirmModifyAction() {
        currentPet?.name = infoCell.nameTextField.text
        currentPet?.gender = infoCell.currentGender.rawValue
        currentPet?.petType = infoCell.currentPetType.rawValue
        currentPet?.id = infoCell.idTextField.text
        currentPet?.birth = Int64(infoCell.currentDate.timeIntervalSince1970)
        currentPet?.breed = infoCell.breedTextField.text
        currentPet?.color = infoCell.colorTextField.text
        
        StorageManager.shared.saveAll()
        
        self.dismiss(animated: false, completion: nil)
    }
}

extension ModifyBaseInfoViewController: UITableViewDelegate {
    
}

extension ModifyBaseInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let currentPet = currentPet
        else {
            return infoCell
        }
        infoCell.layoutCell(name: currentPet.name,
                        gender: currentPet.gender,
                        petType: currentPet.getPetType().rawValue,
                        petId: currentPet.id,
                        birth: currentPet.getBirth(),
                        breed: currentPet.breed,
                        color: currentPet.color)
        return infoCell
    }
    
}
