//
//  WeightLabelTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class WeightLabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(date: String, weight: String) {
        dataLabel.text = date
        weightLabel.text = "\(weight) kg"
    }
    
}
