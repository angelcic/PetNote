//
//  ProfileTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var petImageView: UIImageView!
    
    @IBOutlet weak var addPetLabel: UILabel!
    
    @IBOutlet weak var dataLayer: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    func setImage(name: String) {
        petImageView.image = UIImage(named: name)
    }
    
    func setText(name: String, gender: String, birth: String) {
        dataLayer.isHidden = false
        nameLabel.text = name
        genderLabel.text = gender
        birthdayLabel.text = birth
    }
    
    func showAddPetLabel() {
        dataLayer.isHidden = true
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        petImageView.addCorner(cornerRadius: 50)
//            petImageView.frame.height * 0.5)
       
//        petImageView.addBorder(borderColor: .lightGray, borderWidth: 2, cornerRadius: 50)
        
//        self.addCorner(cornerRadius: 30)
        self.addBorder(borderColor: .lightGray, borderWidth: 2, cornerRadius: 60)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
