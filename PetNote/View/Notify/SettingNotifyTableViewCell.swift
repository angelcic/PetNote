//
//  NotifyTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

enum RepeatType: String {
    case once = "不重複"
    case day = "每日"
    case week = "每週"
    case month = "每月"
    case year = "每年"
    
    var componentSet: Set<Calendar.Component> {
        switch self {
        case .once:
            return [.hour, .minute]
        case .day:
            return [.hour, .minute]
        case .week:
            return [.weekday, .hour, .minute]
        case .month:
            return [.month, .hour, .minute]
        case .year:
            return [.year, .hour, .minute]
        }
    }
    
    var isRepeat: Bool {
        switch self {
        case .once:
            return false
        default:
            return true
        }
    }
    
    static func getTypesCount() -> Int {
        return 5
    }
    
    static func getName(index: Int) -> String {
        switch index {
        case 0:
            return RepeatType.once.rawValue
        case 1:
            return RepeatType.day.rawValue
        case 2:
            return RepeatType.week.rawValue
        case 3:
            return RepeatType.month.rawValue
        case 4:
            return RepeatType.year.rawValue
        default:
            return RepeatType.once.rawValue
            
        }
    }
}

class SettingNotifyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var notifySwitch: UISwitch! {
        didSet {
            notifySwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        }
    }
    
    @IBOutlet weak var frequencyTextField: UITextField! {
        didSet {
            //             frequencyTextField.delegate = self
            frequencyTextField.inputView = frequencyPicker
            frequencyTextField.text = RepeatType.getName(index: 0)
        }
    }
    
    @IBOutlet weak var nextNotifyDateTextField: UITextField! {
        didSet {
            nextNotifyDateTextField.inputView = nextNotifyDatePicker
            
        }
    }
    
    @IBOutlet weak var notifyTimeTextField: UITextField! {
        didSet {
            notifyTimeTextField.inputView = notifyTimePicker
        }
    }
    
    @IBOutlet weak var notifyTextView: UITextView! {
        didSet {
            notifyTextView.addBorder(borderColor: .gray, borderWidth: 1, cornerRadius: 20)
            notifyTextView.delegate = self
        }
    }    
    
    var frequencyPicker = UIPickerView()
    let nextNotifyDatePicker = UIDatePicker()
    let notifyTimePicker = UIDatePicker()
    
    var notificationObject: NotificationObject = NotificationObject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        frequencyPicker.delegate = self
        frequencyPicker.dataSource = self
        setupDatePicker()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupDatePicker() {
        nextNotifyDatePicker.datePickerMode = .date
        nextNotifyDatePicker.locale = Locale(
            identifier: "zh_TW")
        nextNotifyDatePicker.addTarget(self, action: #selector(modifyDate), for: .valueChanged)
        
        notifyTimePicker.datePickerMode = .time
        notifyTimePicker.minuteInterval = 1
        notifyTimePicker.locale = Locale(
            identifier: "zh_TW")
        notifyTimePicker.addTarget(self, action: #selector(modifyDate), for: .valueChanged)
    }
    
    func layoutCell(notification: NotificationObject?) {
        if let notification = notification {
            notificationObject = notification
        }
        
        notifySwitch.isOn = notificationObject.isSwitchOn
        
        frequencyTextField.text = notificationObject.frequencyTypes
        
        nextNotifyDateTextField.text = notificationObject.nextDate.getDateString()
        
        notifyTimeTextField.text = notificationObject.alertTime.getDateString(format: "HH:mm")
        
        notifyTextView.text = notificationObject.alertText
    }
    
    func getNotifySetting() -> NotificationObject {
        return notificationObject
    }
    
    @objc func modifyDate(datePicker: UIDatePicker) {
        
        switch datePicker {
        case nextNotifyDatePicker:
            let nextDate = nextNotifyDatePicker.date
            print("日期： \(nextDate.timeIntervalSince1970)")
            notificationObject.nextDate = nextDate
            nextNotifyDateTextField.text = nextDate.getDateString()
            nextNotifyDateTextField.resignFirstResponder()
            
        case notifyTimePicker:
            let notifyTime = notifyTimePicker.date
            print("時間： \(notifyTime.timeIntervalSince1970)")
            notificationObject.alertTime = notifyTime
            let notifyTimeText = notifyTime.getDateString(format: "HH:mm")
            
            notifyTimeTextField.text = notifyTimeText
            notifyTimeTextField.resignFirstResponder()
        default:
            return
        }
        
    }
    
    @objc func switchAction(sender: UISwitch) {
        notificationObject.isSwitchOn = sender.isOn
    }
    
}

// 選擇重複類型後要顯示在 textField 上
extension SettingNotifyTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let repeatType = RepeatType.getName(index: row)
        frequencyTextField.text = repeatType
        notificationObject.frequencyTypes = repeatType
    }
}

extension SettingNotifyTableViewCell: UIPickerViewDataSource {
    // pickerView 欄位數量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // pickerView 行數
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        return frequencyTypes.count
        return RepeatType.getTypesCount()
    }
    
    // pickerView 每行顯示文字
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        return frequencyTypes[row]
        return RepeatType.getName(index: row)
    }
    
}

extension SettingNotifyTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        notificationObject.alertText = textView.text
    }
}

struct NotificationObject {
    var isSwitchOn: Bool = false
    var frequencyTypes: String = RepeatType.once.rawValue
    var nextDate: Date = Date()
    var alertTime: Date = Date()
    var alertText: String = "預防計畫預定日期到囉"
}
