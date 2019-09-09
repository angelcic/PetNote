//
//  TitleWithButtonTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class TitleWithButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(title: String, buttonTitle: String?) {
        titleLabel.text = title
        if let buttonTitle =  buttonTitle {
            rightButton.setTitle("\(buttonTitle) 〉", for: .normal)
        }
    }
    
}
