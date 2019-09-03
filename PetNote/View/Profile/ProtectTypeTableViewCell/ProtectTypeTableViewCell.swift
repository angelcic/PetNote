//
//  ProtectTypeTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProtectTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var textFieldLayer: UIView!
    
    @IBOutlet weak var otherTectField: UITextField!
    
    let isSelectedImage: UIImage? = UIImage(named: "icons8-checked-checkbox-50")
    
    let isDeSelectedImage: UIImage? = UIImage(named: "icons8-unchecked-checkbox-50")
    
    weak var delegate: ProtectTypeTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkButton.setImage(isDeSelectedImage, for: .normal)
//        checkButton.setImage(isSelectedImage, for: .selected)
//        checkButton.imageView?.image = isDeSelectedImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(title: String, hideTextField: Bool) {
        titleLabel.text = title
        textFieldLayer.isHidden = hideTextField
    }
    
    @IBAction func checkAction(_ sender: Any) {
        delegate?.checkAction(cell: self)
    }
    
    func changeSelectedStatus(_ isSelected: Bool) {
        if isSelected {
            checkButton.setImage(isSelectedImage, for: .normal)
//            checkButton.imageView?.image = isSelectedImage
        } else {
            checkButton.setImage(isDeSelectedImage, for: .normal)
//            checkButton.imageView?.image = isDeSelectedImage
        }
    }
    
}

protocol ProtectTypeTableViewCellDelegate: AnyObject {
    func checkAction(cell: UITableViewCell)
}
