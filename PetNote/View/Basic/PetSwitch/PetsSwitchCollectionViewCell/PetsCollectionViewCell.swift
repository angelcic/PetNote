//
//  PetsCollectionViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/8/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class PetsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var petImageView: UIImageView! {
        didSet {
            petImageView.backgroundColor = .lightCoral
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
           didSet {
               nameLabel.textColor = .pnBlueDark
           }
       }
    
    @IBOutlet weak var petImageBorderView: UIView! {
        didSet {
//            petImageBorderView.backgroundColor = .lightCoral
        }
    }
    
    var petPhotoObserver: NSKeyValueObservation!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        petImageView.addCorner(cornerRadius: petImageView.frame.height * 0.5)
        petImageBorderView.addBorder(borderColor: .white,
                                     borderWidth: 2,
                                     cornerRadius: petImageBorderView.frame.height * 0.5)
    }
    
    func layoutCell(image: UIImage?, name: String?) {
        petImageView.image = image
        nameLabel.text = name
    }
    
    func changeSlectedStatus(_ isSelected: Bool) {
        if isSelected {
            petImageBorderView.isHidden = false
        } else {
            petImageBorderView.isHidden = true
        }
    }
    
    func changeSlectedStatus() {
        if isSelected {
            petImageBorderView.isHidden = false
        } else {
            petImageBorderView.isHidden = true
        }
    }
}
