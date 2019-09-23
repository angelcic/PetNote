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
            detailView.backgroundColor = .white
        }
    }
    
    var pets: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "毛孩資料"
    
//        setupContainerView()
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        
        let saveButton = UIBarButtonItem(title: "新增成員", style: .plain, target: self, action: #selector(addPetAction))
        saveButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.pnWhite], for: .normal)
        
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if let containerVC = segue.destination as? BaseContainerViewController {
//            containerVCs.append(containerVC)
//        }
    }
    
}

extension ProfileDetailViewController: ProfileDetailViewDelegate {
    
}

extension ProfileDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetsCollectionViewCell.identifier, for: indexPath) as? PetsCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        return cell
    }
        
}

extension ProfileDetailViewController: UICollectionViewDelegate {
    
}
