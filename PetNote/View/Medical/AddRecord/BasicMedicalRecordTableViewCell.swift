//
//  BasicMedicalRecordTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class BasicMedicalRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var medicalImageView: UIImageView!
    
    @IBOutlet weak var addImageButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        medicalImageView.addCorner(cornerRadius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addImageAction(_ sender: Any) {
    }
}
