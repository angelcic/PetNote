//
//  AddPetView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/12.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol AddPetViewDelegate: AnyObject {
    func cancelAction()
    func confirmAction(name: String, type: PetType)
}

class AddPetView: UIView {

    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var nameAlertLabel: UILabel!
    
    @IBOutlet weak var typeOneButton: UIButton! {
        didSet {
            typeOneButton.addBorder(borderColor: .darkGray, borderWidth: 1, cornerRadius: 10)
            typeOneButton.setTitleColor(.lightGray, for: .normal)
            typeOneButton.setTitleColor(.darkGray, for: .selected)
            typeOneButton.addTarget(self, action: #selector(didSelectedAt), for: .touchUpInside)
            typeOneButton.tag = 0
            typeOneButton.isSelected = true
        }
    }
    
    @IBOutlet weak var typeTwoButton: UIButton! {
        didSet {
            typeTwoButton.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 10)
            typeTwoButton.setTitleColor(.lightGray, for: .normal)
            typeTwoButton.setTitleColor(.darkGray, for: .selected)
            typeTwoButton.addTarget(self, action: #selector(didSelectedAt), for: .touchUpInside)
            typeTwoButton.tag = 1
        }
    }
    
    @IBOutlet weak var typeThreeButton: UIButton! {
        didSet {
            typeThreeButton.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 10)
            typeThreeButton.setTitleColor(.lightGray, for: .normal)
            typeThreeButton.setTitleColor(.darkGray, for: .selected)
            typeThreeButton.addTarget(self, action: #selector(didSelectedAt), for: .touchUpInside)
            typeThreeButton.tag = 2
        }
    }
    
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.tintColor = .gray
        }
    }
    
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.tintColor = .gray
        }
    }
    
    let petType: [PetType] = [.cat, .dog, .other]
    
    lazy var petTypeButtons: [UIButton] =  [typeOneButton, typeTwoButton, typeThreeButton]    
    
    var currentType = 0
    
    weak var delegate: AddPetViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func didSelectedAt(sender: UIButton) {
        for button in petTypeButtons {
            button.isSelected = false
        }
        sender.isSelected = true
        currentType = sender.tag
        changeButtonStatus()
    }
    
    func changeButtonStatus() {
        for button in petTypeButtons {
            if button.isSelected {
                button.addBorder(borderColor: .darkGray, borderWidth: 1, cornerRadius: 10)
            } else {
                button.addBorder(borderColor: .lightGray, borderWidth: 1, cornerRadius: 10)
            }
        }
    }
       
    @IBAction func cancelAction(_ sender: Any) {
        delegate?.cancelAction()
    }
    
    @IBAction func confirmAction(_ sender: Any) {
        
        guard
            let name = nameTextField.text, !name.isBlank
        else {
            nameAlertLabel.isHidden = false
            return
        }
        
        let type = petType[currentType]
        
        delegate?.confirmAction(name: name, type: type)
    }
}

extension AddPetView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if let name = textField.text, !name.isBlank {
            nameAlertLabel.isHidden = true
        } else {
            nameAlertLabel.isHidden = false
        }
    }
}
