//
//  HealthRecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class HealthRecordViewController: BaseContainerViewController {
    func petDidChange() {
        // TODO: 切換寵物
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    let functions: [String] = ["體重記錄", "血糖記錄"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setCollectionView() {
        collectionView.registerCellWithNib(identifier: String(describing: BasicCollectionViewCell.self), bundle: nil)
    }
}

extension HealthRecordViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO:
        let weightRecordVC = UIStoryboard.profile.instantiateViewController(
            withIdentifier: String(describing: WeightRecordViewController.self))
        show(weightRecordVC, sender: nil)
    }
}

extension HealthRecordViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functions.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let
            cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BasicCollectionViewCell.identifier,
                for: indexPath)
                as? BasicCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.layoutCell(title: functions[indexPath.row])
        return cell
    }
    
}

extension HealthRecordViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        
         return CGSize(width: UIScreen.width / 3.0, height: UIScreen.width / 3.0)
    }
}
