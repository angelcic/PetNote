//
//  MedicalBasicTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class MedicalBasicTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self.delegate
            collectionView.dataSource = self.delegate
        }
    }
    
    weak var delegate: MedicalBasicTableViewCellDelegate? {
        didSet {
            collectionView.delegate = self.delegate
            collectionView.dataSource = self.delegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCollectionView() {
        collectionView.registerCellWithNib(identifier: String(describing: BasicCollectionViewCell.self), bundle: nil)
    }
    
}

protocol MedicalBasicTableViewCellDelegate: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AnyObject {
    
}

extension MedicalBasicTableViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
}
