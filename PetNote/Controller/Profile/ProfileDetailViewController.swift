//
//  ProfileDetailViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProfileDetailViewController: SwitchPetViewController, SwitchPetViewControllerProtocol {

    @IBOutlet var detailView: ProfileDetailView! {
        didSet {
            detailView.delegate = self
            detailView.backgroundColor = .white
        }
    }
    
    var containerVCs: [BaseContainerViewController] = []
    var storageManger = StorageManager.shared
    
//    var pets: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "毛孩資料"
    
        setupContainerView()
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        
        let saveButton = UIBarButtonItem(title: "新增成員", style: .plain, target: self, action: #selector(addPetAction))
//        saveButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.pnWhite], for: .normal)
        
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let containerVC = segue.destination as? BaseContainerViewController {
            containerVCs.append(containerVC)
        }
    }
    
    @objc func addPetAction() {
        showAddPetVC()
    }
    
    func setupContainerView() {
        if storageManger.petsList.count > 0 {
            containerVCs.forEach({
                $0.currentPet = storageManger.petsList[0]
            })
        }
    }

    func petsNumberChange(isEmpty: Bool) {
        detailView.changeAddPetAlertStatus(isHidden: !isEmpty)
    }
    
    // 切換寵物
    func changePet(_ indexPath: IndexPath ) {
        changePet(indexPath.row)
    }
    
    func changePet(_ index: Int) {
        if storageManger.petsList.count > 0 {
            containerVCs.forEach({
                $0.currentPet = storageManger.petsList[index]
            })
        }
    }
    
    func updateSwitchView() {
        detailView.updateSwitchView()
        changePet(storageManger.currentPetIndex)
    }
    
}

extension ProfileDetailViewController: ProfileDetailViewDelegate {
    
}
