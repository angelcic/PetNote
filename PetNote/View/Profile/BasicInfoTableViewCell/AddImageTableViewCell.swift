//
//  AddImageTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol AddImageTableViewCellDelegate: AnyObject {
    func pressAddImageButton(_ cell: AddImageTableViewCell)
}

class AddImageTableViewCell: UITableViewCell {

    @IBOutlet weak var petImageView: UIImageView! {
        didSet {
            petImageView.layer.cornerRadius = 75
            petImageView.clipsToBounds = true
            petImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.addCorner(cornerRadius: 20)
        }
    }
    
    @IBOutlet weak var addImageView: UIView! {
        didSet {
            addImageView.addCorner(cornerRadius: 5)
            let tapAction =  UITapGestureRecognizer(target: self, action: #selector(addImageAction))
            addImageView.addGestureRecognizer(tapAction)
        }
    }
    
    weak var delegate: AddImageTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(image: UIImage?) {
        
        petImageView.image = image
        
    }
    
    @objc func addImageAction(_ sender: Any) {
        
        delegate?.pressAddImageButton(self)
        
    }
}
