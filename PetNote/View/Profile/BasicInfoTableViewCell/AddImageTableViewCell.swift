//
//  AddImageTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol AddImageTableViewCellDelegate: AnyObject {
    func pressAddImageButton()
}

class AddImageTableViewCell: UITableViewCell {

    @IBOutlet weak var petImageView: UIImageView! {
        didSet {
//            petImageView.backgroundColor = .orange
            petImageView.layer.cornerRadius = 30
            petImageView.clipsToBounds = true
            petImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var addImageView: UIView! {
        didSet {
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
        
        delegate?.pressAddImageButton()
        
    }
}
