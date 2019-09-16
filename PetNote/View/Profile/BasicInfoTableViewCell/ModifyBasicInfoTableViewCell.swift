//
//  ModifyBasicInfoTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/15.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ModifyBasicInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var genderGirlButton: UIButton!
    @IBOutlet weak var genderBoyButton: UIButton!
    
    @IBOutlet weak var typeCatButton: UIButton!
    @IBOutlet weak var typeDogButton: UIButton!
    @IBOutlet weak var typeOtherButton: UIButton!
    
    lazy var genderButtons: [UIButton] =  [genderGirlButton, genderBoyButton]
    
    lazy var petTypeButtons: [UIButton] =  [typeCatButton, typeDogButton, typeOtherButton]
    
    var currentGender: Gender = .girl
    var currentPetType: PetType = .cat
    
    var pet: PNPetInfo = PNPetInfo() {
        didSet {
            currentGender = Gender.init(rawValue: pet.gender ?? "girl") ?? .girl
            currentPetType = PetType.init(rawValue: pet.petType ?? "cat") ?? .cat
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupGenderButton()
        setupTypeButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupGenderButton() {
        for (index, button) in genderButtons.enumerated() {
//            if index == currentGender.getGenderIndex() {
//                button.isSelected = true
//            }
            if button.titleLabel?.text == pet.gender {
                button.isSelected = true
            }
            button.tag = index
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.addBorder(borderColor: .gray, borderWidth: 1, cornerRadius: 8)
            button.addTarget(self, action: #selector(changeGender), for: .touchUpInside)
        }
    }

    func setupTypeButton() {
        for (index, button) in petTypeButtons.enumerated() {
            if index == currentPetType.getPetTypeIndex() {
                button.isSelected = true
            }
            button.tag = index
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.darkGray, for: .selected)
            button.addBorder(borderColor: .gray, borderWidth: 1, cornerRadius: 8)
            button.addTarget(self, action: #selector(changePetType), for: .touchUpInside)
        }
    }
    
    @objc func changeGender(sender: UIButton) {
        currentGender = Gender.getGender(with: sender.tag)
        for button in genderButtons {
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @objc func changePetType(sender: UIButton) {
        currentPetType = PetType.getPetType(with: sender.tag)
        for button in petTypeButtons {
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @IBAction func confirmModifyAction() {
        
    }
}
