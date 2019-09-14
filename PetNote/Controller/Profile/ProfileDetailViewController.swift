//
//  ProfileDetailViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProfileDetailViewController: BaseSwitchPetViewController {

    @IBOutlet var detailView: ProfileDetailView! {
        didSet {
            detailView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "毛孩資料"
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        
        let saveButton = UIBarButtonItem(title: "新增成員", style: .plain, target: self, action: #selector(addPetAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func addPetAction() {
        showAddPetVC()
    }
    
    func changePet() {
        // TODO:
    }
    
    func updateSwitchView() {
        detailView.updateSwitchView()
    }
}

extension ProfileDetailViewController: ProfileDetailViewDelegate {

    func changePet(_ indexPath: IndexPath) {
        // TODO
    }
}
