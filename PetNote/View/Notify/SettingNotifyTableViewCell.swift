//
//  NotifyTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SettingNotifyTableViewCell: UITableViewCell {

    @IBOutlet weak var notifySwitch: UISwitch!
    
     @IBOutlet weak var frequencyTextField: UITextField!
    
    @IBOutlet weak var nextNotifyDate: UITextField!
    
    @IBOutlet weak var lastNotifyDate: UITextField!
    
    @IBOutlet weak var notifyTime: UITextField!
    
    @IBOutlet weak var notifyTextView: UITextView! {
        didSet {
            notifyTextView.addBorder(borderColor: .gray, borderWidth: 1, cornerRadius: 20)
        }
    }    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
