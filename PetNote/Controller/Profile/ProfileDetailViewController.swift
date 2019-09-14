//
//  ProfileDetailViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProfileDetailViewController: BaseViewController {

    @IBOutlet var detailView: ProfileDetailView! {
        didSet {
            detailView.delegate = self
        }
    }
   
    let storageManager = StorageManager.shared
    
//    var pets: [Pet] = []
    
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
        
        guard let addPetVC = UIStoryboard.profile.instantiateViewController(
            withIdentifier: AddPetViewController.identifier)
            as? AddPetViewController
            else {return}
        
        addPetVC.delegate = self
        
        // 顯示樣式
        addPetVC.modalPresentationStyle = UIModalPresentationStyle.custom
        
        self.present(addPetVC, animated: false, completion: nil)
        
        addPetVC.view.backgroundColor = UIColor.clear
    }
}

extension ProfileDetailViewController: AddPetViewControllerDelegate {
    func addPetResult(_ result: Result<Void, Error>) {
        switch result {
        case .success:
            detailView.updateSwitchView()
        case .failure(let error) :
            print(error)
        }
    }
}

extension ProfileDetailViewController: ProfileDetailViewDelegate {

    func changePet(_ indexPath: IndexPath) {
        // TODO
    }
}
