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
    
    @IBOutlet weak var isNeuterButton: UIButton!
    @IBOutlet weak var unNeuterButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField! {
        didSet {
            birthTextField.setInputViewDatePicker(target: self, selector: #selector(modifyDate))
        }
    }
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    
    lazy var genderButtons: [UIButton] =  [genderGirlButton, genderBoyButton]
    
    lazy var petTypeButtons: [UIButton] =  [typeCatButton, typeDogButton, typeOtherButton]
    
    lazy var neuterButtons: [UIButton] = [isNeuterButton, unNeuterButton]
    
    var currentGender: Gender = .girl
    
    var currentPetType: PetType = .cat
    
    var currentNeuterType: String = Neuter.unNeuter.rawValue
    
    var currentDate: Date = Date()
    
    lazy var birthDay: Date = currentDate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setupGenderButton()
//        setupTypeButton()
//        setupNeuterButton()
        
        setupButtonGroup(
            group: genderButtons,
            currentTitle: currentGender.rawValue,
            selector: #selector(changeGenderStatus)
        )
        setupButtonGroup(
            group: petTypeButtons,
            currentTitle: currentPetType.rawValue,
            selector: #selector(changePetTypeStatus)
        )
        setupButtonGroup(
            group: neuterButtons,
            currentTitle: currentNeuterType,
            selector: #selector(changeNeuterStatus)
        )
        
    }
    
    func setupDatePicker() {
        if let datePicker = self.birthTextField.inputView as? UIDatePicker {
            datePicker.date = birthDay
        }
    }
    
    @objc func modifyDate() {
        if let datePicker = self.birthTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy年MM月dd日"
            
            birthDay = datePicker.date
            
            self.birthTextField.text =  dateformatter.string(from: birthDay)
            
        }
        // 完成輸入，關閉 pickerView
        self.birthTextField.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupButtonGroup(group: [UIButton], currentTitle: String, selector: Selector) {
        for button in group {
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
            button.addTarget(self, action: selector, for: .touchUpInside)
            
            if button.titleLabel?.text == currentTitle {
                button.isSelected = true
                button.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
            }
        }
    }
    
//    func setupGenderButton() {
//        for button in genderButtons {
//
//            button.setTitleColor(.lightGray, for: .normal)
//            button.setTitleColor(.black, for: .selected)
//            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
//            button.addTarget(self, action: #selector(changeGenderStatus), for: .touchUpInside)
//
//            if button.titleLabel?.text == currentGender.rawValue {
//                button.isSelected = true
//                button.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
//            }
//        }
//    }
//
//    func setupTypeButton() {
//        for button in petTypeButtons {
//
//            button.setTitleColor(.lightGray, for: .normal)
//            button.setTitleColor(.black, for: .selected)
//            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
//            button.addTarget(self, action: #selector(changePetTypeStatus), for: .touchUpInside)
//
//            if button.titleLabel?.text == currentPetType.rawValue {
//                button.isSelected = true
//                button.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
//            }
//        }
//    }
//
//    func setupNeuterButton() {
//        for button in neuterButtons {
//
//            button.setTitleColor(.lightGray, for: .normal)
//            button.setTitleColor(.black, for: .selected)
//            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
//            button.addTarget(self, action: #selector(changeNeuterStatus), for: .touchUpInside)
//
//            if button.titleLabel?.text == currentNeuterType {
//                button.isSelected = true
//                button.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
//            }
//        }
//    }
    
    //swiftlint:disable function_parameter_count
    func layoutCell(name: String?, gender: String?,
                    petType: String?, neuter: String?, petId: String?,
                    birth: Int?, breed: String?, color: String?) {
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
                if $0.titleLabel?.text == petType {
                    changePetTypeStatus(sender: $0)
                }
            }
        }
        
        if let neuter = neuter {
            currentNeuterType = neuter
            neuterButtons.forEach {
                if $0.titleLabel?.text == currentNeuterType {
                    changeNeuterStatus(sender: $0)
                }
            }
        }
        
        idTextField.text = petId
        if let birth = birth, birth != 0 {
            birthDay = birth.getDate()
            birthTextField.text = birth.getDateString()
            setupDatePicker()
        } else {
            birthTextField.text = ""
        }
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
            let petType = sender.titleLabel?.text,
            let currentPetType = PetType.init(rawValue: petType)
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
    
    @objc func changeNeuterStatus(sender: UIButton) {
        guard
            let neuter = sender.titleLabel?.text
        else {
            return
        }
        
        self.currentNeuterType = neuter
        
        for button in neuterButtons {
            button.isSelected = false
            button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 8)
        }
        
        sender.isSelected = true
        sender.addBorder(borderColor: .black, borderWidth: 1, cornerRadius: 8)
    }
  
}
