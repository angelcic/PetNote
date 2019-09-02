//
//  BasicCollectionViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundLayer: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundLayer.addBorder(borderColor: .gray, borderWidth: 2, cornerRadius: 20)
    }

}
