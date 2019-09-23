//
//  ProtectPlanTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/19.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProtectPlanTableViewCell: UITableViewCell {

    @IBOutlet weak var protectType: UILabel!
    @IBOutlet weak var planName: UILabel!
    @IBOutlet weak var protectTypeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(type: String?, name: String?) {
        protectType.text = type
        planName.text = name
    }
    
}
