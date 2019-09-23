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
    
    var isSelectedBGColor: UIColor = UIColor.pnBlueDark!
    var deSelectedBGColor: UIColor = UIColor.pnWhite!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundLayer.addBorder(borderColor: .gray, borderWidth: 2, cornerRadius: 20)
    }

    func layoutCell(title: String) {
        titleLabel.text = title
    }
    
    func changeSelectedStatus() {
        if isSelected {
            setSelectedBG()
        } else {
            backgroundLayer.backgroundColor = deSelectedBGColor
            titleLabel.textColor = .gray
        }
    }
    
    func setSelectedBG() {
        backgroundLayer.backgroundColor = isSelectedBGColor
        titleLabel.textColor = .white
    }
    
}
