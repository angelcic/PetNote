//
//  MedicalRecordTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class MedicalRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundLayer: UIView!
    
    @IBOutlet weak var addLayer: UIView!
    
    @IBOutlet weak var houspitalNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var reasonLabel: UILabel!
    
    weak var delegate: MedicalRecordTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addLayer.isHidden = true
        backgroundLayer.addBorder(borderColor: .gray, borderWidth: 1, cornerRadius: 30)
    }
    
    func layoutCell(name: String?, time: String?, reason: String?) {
        addLayer.isHidden = true
        houspitalNameLabel.text = name ?? "尚無醫院名字"
        timeLabel.text = time ?? "尚無就診時間"
        reasonLabel.text = reason ?? "尚無就診原因"
    }
    
    func showAddLayer() {
        addLayer.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addAction(_ sender: Any) {
        delegate?.pressAddButton()
    }
}

protocol MedicalRecordTableViewCellDelegate: AnyObject {
    func pressAddButton()
}
