//
//  TitleWithDateTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class TitleWithDateTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
