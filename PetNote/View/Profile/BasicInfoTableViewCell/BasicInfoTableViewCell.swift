//
//  BasicInfoTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol BasicInfoTableViewCellDelegate: AnyObject {
    func pressModifyButton()
    func pressDeleteButton()
}

class BasicInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.addBorder(borderColor: UIColor.pnBlueLight!, borderWidth: 1, cornerRadius: 5)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var neuterLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    weak var delegate: BasicInfoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //swiftlint:disable function_parameter_count
    func layoutCell(name: String?, gender: String?,
                    petType: String?, neuter: String?,
                    petId: String?,
                    birth: String?, breed: String?, color: String?) {
        nameLabel.text = name
        genderLabel.text = gender
        petTypeLabel.text = petType
        neuterLabel.text = neuter
        idLabel.text = petId
        birthLabel.text = birth
        breedLabel.text = breed
        colorLabel.text = color
    }
    //swiftlint:enable function_parameter_count
    
    @IBAction func pressModifyButton() {
        delegate?.pressModifyButton()
    }
        
    @IBAction func pressDeleteButton() {
        delegate?.pressDeleteButton()
    }
}
