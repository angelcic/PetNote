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

    @IBOutlet weak var petImageView: UIImageView!
    
    @IBOutlet weak var addImageButton: UIButton!
    
    weak var delegate: AddImageTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addImageAction(_ sender: Any) {
        
        delegate?.pressAddImageButton()
        
    }
}
