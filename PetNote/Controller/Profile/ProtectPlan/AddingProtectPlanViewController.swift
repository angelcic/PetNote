//
//  AddingProtectPlanViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddingProtectPlanViewController: BaseViewController {
    
    let protectPlans: [String] = ["疫苗", "體內驅蟲", "體外驅蟲", "其他"]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.tabBarController?.tabBar.isHidden = true
        
        setCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setCollectionView() {
        collectionView.registerCellWithNib(identifier: String(describing: BasicCollectionViewCell.self), bundle: nil)
    }
    
}

extension AddingProtectPlanViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return protectPlans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath)
                as? BasicCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        cell.layoutCell(title: protectPlans[indexPath.row])
        return cell
    }
    
}

extension AddingProtectPlanViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for cell in collectionView.visibleCells {
            if let cell = cell as? BasicCollectionViewCell {
                cell.changeSelectedStatus()
            }
        }
//        if let cell = collectionView.cellForItem(at: indexPath)
//            as? BasicCollectionViewCell {
//            cell.changeSelectedStatus()
//        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath)
            as? BasicCollectionViewCell {
            cell.changeSelectedStatus()
        }
    }
    
}

extension AddingProtectPlanViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        
        return CGSize(width: UIScreen.width / 5.0, height: UIScreen.width / 5.0)
    }
}

extension AddingProtectPlanViewController: UITableViewDelegate {
    
}

extension AddingProtectPlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }    
    
}
