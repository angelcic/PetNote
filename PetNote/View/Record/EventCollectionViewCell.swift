//
//  eventCollectionViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/24.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroudImageView: UIView! {
        didSet {
            backgroudImageView.addCorner(cornerRadius: 5)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func layoutCell(title: String?) {
        titleLabel.text = title
    }

}
