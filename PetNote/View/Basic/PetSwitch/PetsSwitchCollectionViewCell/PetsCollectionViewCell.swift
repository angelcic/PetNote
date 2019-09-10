//
//  PetsCollectionViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/8/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class PetsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var petImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        petImageView.addCorner(cornerRadius: petImageView.frame.height * 0.5)
    }
}
