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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    
    lazy var genderButtons: [UIButton] =  [genderGirlButton, genderBoyButton]
    
    lazy var petTypeButtons: [UIButton] =  [typeCatButton, typeDogButton, typeOtherButton]
    
    var currentGender: Gender = .girl {
        didSet {
            
        }
    }
    var currentPetType: PetType = .cat
    
    var currentDate: Date = Date()
    
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
        for button in genderButtons {
            
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
            button.addTarget(self, action: #selector(changeGenderStatus), for: .touchUpInside)
            
            if button.titleLabel?.text == currentGender.rawValue {
                button.isSelected = true
                button.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
            }
        }
    }

    func setupTypeButton() {
        for button in petTypeButtons {
            
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
            button.addTarget(self, action: #selector(changePetTypeStatus), for: .touchUpInside)
            
            if button.titleLabel?.text == currentPetType.rawValue {
                button.isSelected = true
                button.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
            }
        }
    }
    //swiftlint:disable function_parameter_count
    func layoutCell(name: String?, gender: String?,
                    petType: String?, petId: String?,
                    birth: String?, breed: String?, color: String?) {
        nameTextField.text = name
        if let gender = gender,
            let currentGender = Gender.init(rawValue: gender) {
            self.currentGender = currentGender
            genderButtons.forEach {
                if $0.titleLabel?.text == gender {
                    changeGenderStatus(sender: $0)
                }
            }
        }
        if let petType = petType,
            let currentPetType = PetType.init(rawValue: petType) {
            self.currentPetType = currentPetType
            petTypeButtons.forEach {
                if $0.titleLabel?.text == gender {
                    changePetTypeStatus(sender: $0)
                }
            }
        }
        idTextField.text = petId
        birthTextField.text = birth
        breedTextField.text = breed
        colorTextField.text = color
    }
    //swiftlint:enable function_parameter_count
    
    @objc func changeGenderStatus(sender: UIButton) {
        guard
            let gender = sender.titleLabel?.text,
            let currentGender = Gender.init(rawValue: gender)
        else {
            return
        }
        
        self.currentGender = currentGender
        
        for button in genderButtons {
            button.isSelected = false
            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        }
        
        sender.isSelected = true
        sender.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
    }
    
    @objc func changePetTypeStatus(sender: UIButton) {
        guard
            let gender = sender.titleLabel?.text,
            let currentPetType = PetType.init(rawValue: gender)
            else {
                return
        }
        
        self.currentPetType = currentPetType
        
        for button in petTypeButtons {
            button.isSelected = false
            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        }
        
        sender.isSelected = true
        sender.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
    }
    
    @IBAction func confirmModifyAction() {
        
    }
}
