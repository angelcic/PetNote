//
//  ChartTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol ChartTableViewCellDelegate: AnyObject {
    func addWeightRecord(date: Int, weight: Double)
}

class ChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chartLayer: UIView!
    
    @IBOutlet weak var dateTextField: UITextField! {
        didSet {
            dateTextField.text = Date().getDateString()
            dateTextField.setInputViewDatePicker(target: self, selector: #selector(modifyDate))
        }
    }
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: ChartTableViewCellDelegate?
    
    var recordDate = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func modifyDate() {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker {
            
            recordDate = datePicker.date
            self.dateTextField.text =  recordDate.getDateString()
            
        }
        // 完成輸入，關閉 pickerView
        self.dateTextField.resignFirstResponder()
    }
    
    @IBAction func addAction(_ sender: Any) {
        guard
            let weightText = weightTextField.text, !weightText.isBlank,
        let weight = Double(weightText)
        else {
            print("請輸入體重")
            alertLabel.isHidden = false
            return
        }
        alertLabel.isHidden = true
        weightTextField.text = ""
        
        let date = Int(recordDate.timeIntervalSince1970)
        
        delegate?.addWeightRecord(date: date, weight: weight)
    }
}
