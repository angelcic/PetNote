//
//  MedicalViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class MedicalViewController: SwitchPetViewController, SwitchPetViewControllerProtocol {
   
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var switchPetLayer: UIView! {
        didSet {
            switchPetLayer.addSubview(switchPetView)
        }
    }
    
//    var switchPetView = SwitchPetView() 
    
    var medicalRecords: [MedicalRecord] = [MedicalRecord(), MedicalRecord(), MedicalRecord()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        switchPetView.delegate = self
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
//        setupSwitchPetView()
    }
    
    func setupSwitchPetView() {
        switchPetView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: switchPetLayer.frame.size)
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: MedicalRecordTableViewCell.self), bundle: nil)
    }
    
    func showAddRecordPage() {
        guard let addMedicalRecordVC = UIStoryboard.medical.instantiateViewController(
            withIdentifier: String(describing: AddMedicalRecordViewController.self))
            as? AddMedicalRecordViewController
            else {
                return
        }        
        show(addMedicalRecordVC, sender: nil)
    }
    
    func petsNumberChange(_ viewController: SwitchPetViewController?, isEmpty: Bool) {
        //        TODO: NOOOOOOO PET
    }

    func changePet(_ viewController: SwitchPetViewController?, _ indexPath: IndexPath) {
        // TODO:
    }
    
    func updateSwitchView() {
        switchPetView.updatePetsData()
    }
}

//extension MedicalViewController: SwitchPetViewDelegate {
//    func changePet() {
//    }
//}

extension MedicalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            showAddRecordPage()
        }
    }
}

extension MedicalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return medicalRecords.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: MedicalRecordTableViewCell.self),
            for: indexPath)
            as? MedicalRecordTableViewCell
        else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.showAddLayer()
            cell.delegate = self
        default:
            cell.layoutCell(name: nil, time: nil, reason: nil)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension MedicalViewController: MedicalRecordTableViewCellDelegate {
    
    func pressAddButton(_ cell: MedicalRecordTableViewCell) {
        showAddRecordPage()
    }
}
