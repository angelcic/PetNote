//
//  NotificationManageViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class NotificationManageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    let NotificationTypes: [String] = ["疫苗通知", "滴劑通知", "餵藥通知", "回診通知"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        self.navigationItem.title = "通知管理"
    }
    
    func setupCollectionView() {
        collectionView.registerCellWithNib(identifier: String(describing: BasicCollectionViewCell.self), bundle: nil)
    }
    
}

extension NotificationManageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let NotificationVC = UIStoryboard.other.instantiateViewController(withIdentifier: String(describing: NotificatonViewController.self))
        as? NotificatonViewController
            else {
                return
        }
        show(NotificationVC, sender: nil)
    }
}

extension NotificationManageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NotificationTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell( withReuseIdentifier: String(describing: BasicCollectionViewCell.self), for: indexPath)
            as? BasicCollectionViewCell
            else {
                return UICollectionViewCell ()
        }
        cell.layoutCell(title: NotificationTypes[indexPath.row])
        return cell
    }
}
