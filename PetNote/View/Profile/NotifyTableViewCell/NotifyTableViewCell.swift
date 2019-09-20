//
//  NotifyTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol NotifyTableViewCellDelegate: AnyObject {
    func openAlertManager()
}

class NotifyTableViewCell: UITableViewCell {
    @IBOutlet weak var nextExecuteTimeField: UITextField!
    @IBOutlet weak var alertManagerButton: UIButton!
    
    weak var delegate: NotifyTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressAlertManager() {
        delegate?.openAlertManager()
    }
    
}
