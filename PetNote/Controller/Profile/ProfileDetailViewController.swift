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
    
    var containerVCs: [BaseContainerViewController] = []
    var storageManger = StorageManager.shared
    
//    var observer: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "毛孩資料"
        
        setupContainerView()
//        observer = storageManager.observe(\.currentPetIndex, options: [.new, .initial]) {[weak self] (object, change) in
//            print(change)
//            self?.updateSwitchView()
//        }
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        
        let saveButton = UIBarButtonItem(title: "新增成員", style: .plain, target: self, action: #selector(addPetAction))
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
    
    // 切換寵物
    func changePet(_ indexPath: IndexPath ) {
        containerVCs.forEach({
            $0.currentPet = storageManger.petsList[indexPath.row]
        })
    }
    
    func updateSwitchView() {
        detailView.updateSwitchView()
    }
}

extension ProfileDetailViewController: ProfileDetailViewDelegate {
    
}
