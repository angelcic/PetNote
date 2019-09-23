//
//  ProfileDetailViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {

    @IBOutlet var detailView: ProfileDetailView! {
        didSet {
            detailView.delegate = self
        }
    }
    
    var pets: [Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "毛孩資料"
        
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
