//
//  DateSelectTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class DateSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTextField: UITextField! {
        didSet {
            dateTextField.setInputViewDatePicker(target: self, selector: #selector(modifyDate))
        }
    }
    
    lazy var eventDate: Date = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupDatePicker() {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker {
            datePicker.date = eventDate
        }
    }
    
    func layoutCell(eventDate: Date?) {
        guard let date = eventDate
            else { return }
        self.eventDate = date
        self.dateTextField.text =  eventDate?.getDateString()
        setupDatePicker()
    }
    
    @objc func modifyDate() {
        if let datePicker = self.dateTextField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy年MM月dd日"
            
            eventDate = datePicker.date
            
            self.dateTextField.text =  dateformatter.string(from: eventDate)
            
        }
        // 完成輸入，關閉 pickerView
        self.dateTextField.resignFirstResponder()
    }
    
    func getDate() -> Date {
        return eventDate
    }
}
