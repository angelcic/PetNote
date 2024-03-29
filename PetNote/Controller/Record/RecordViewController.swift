//
//  RecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import FSCalendar

class RecordViewController: SwitchPetViewController, SwitchPetViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            if dateRecord.count == 0 {
                selectedDate = calendar.today ?? Date()
            }
        }
    }
    
    @IBOutlet weak var tableViewMaskLayer: UIView! 
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.addCorner(cornerRadius: 30)
        }
    }
    
    @IBOutlet weak var addButtonMask: UIView!
    
    @IBOutlet weak var calendar: FSCalendar! {
        didSet {
            calendar.dataSource = self
            calendar.delegate = self
            
            calendar.appearance.headerTitleColor = UIColor.pnBlueDark
            calendar.appearance.weekdayTextColor = UIColor.pnBlueDark
            calendar.appearance.todayColor = UIColor.pnDarkPink
            calendar.appearance.selectionColor =  UIColor.pnBlueLight
            calendar.appearance.borderRadius = 0.5
        }
    }
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var currentPet: PNPetInfo? {
        didSet {
            resetCurrentRecord()
        }
    }
    
    // 目前寵物的所有 record
    var currentRecord: [PNDailyRecord]? {
        
        didSet {
            
            eventDate = []
            currentRecord?.forEach({
                let date = Date(timeIntervalSince1970: $0.date).getDateString(format: "yyyyMMdd")
                eventDate.append(date)
            })
            resetDateRecord()
        }
    }
    
    // 目前寵物 + 被選擇日期的 record
    var dateRecord: [PNDailyRecord] = []
    
    // 選擇的日期，預設是今天
    var selectedDate: Date = Date() {
        didSet {
            resetDateRecord()
        }
    }
    
    // 有事件的日期
    var eventDate: [String] = [] {
        didSet {
            calendar.reloadData()
        }
    }
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = { [unowned self] in
        let panGesture = UIPanGestureRecognizer(
            target: self.calendar,
            action: #selector(self.calendar.handleScopeGesture(_:))
        )
        
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchPetView.delegate = self
        let index = storageManager.currentPetIndex
        if storageManager.petsList.count > index {
            
            currentPet = storageManager.petsList[index]
        }
        setCalendar()
        setupTableView()
        view.bringSubviewToFront(addButton)
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: DailyRecordTableViewCell.identifier, bundle: nil)
        
        if dateRecord.count == 0 {
            tableViewMaskLayer.isHidden = false
        } else {
            tableViewMaskLayer.isHidden = true
        }
    }
    
    func setCalendar() {
// 加入上滑月曆縮小功能
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
    }
    
    func changePet(_ viewController: SwitchPetViewController?, _ indexPath: IndexPath) {
        let index = indexPath.row
        if StorageManager.shared.petsList.count > index {
            currentPet = StorageManager.shared.petsList[index]
        }
    }
    
    // 若無成員需阻擋加入紀錄操作
    func petsNumberChange(_ viewController: SwitchPetViewController?, isEmpty: Bool) {
        addButtonMask.isHidden = !isEmpty
    }
    
    func resetCurrentRecord() {
        guard
            let pet = currentPet,
            let record = pet.dailyRecord?.sortedArray(
                using: [NSSortDescriptor(key: "date", ascending: false)])
                as? [PNDailyRecord]
        else {
            return
        }
        currentRecord = record
    }
    
    func resetDateRecord() {
        dateRecord = []

        currentRecord?.forEach({
            let date = Date(timeIntervalSince1970: $0.date).getDateString(format: "yyyyMMdd")
            if date == selectedDate.getDateString(format: "yyyyMMdd") {
                dateRecord.append($0)
            }
        })
        tableView.reloadData()

        guard let maskLayer = tableViewMaskLayer else { return }
        
        if dateRecord.count == 0 {
            maskLayer.isHidden = false
        } else {
            maskLayer.isHidden = true
        }
        
    }
    
    func addDailyRecord(date: Date) {
        showAddProtectPlanVC(date: date, dailyRecord: StorageManager.shared.getPNDailyRecord(),
                             title: "添加紀錄") {[weak self] date, event, describe in
                                
            let record = StorageManager.shared.getPNDailyRecord()
                                
                                record.date = date.timeIntervalSince1970
                                record.event = event
                                record.describe = describe
                                
            self?.currentPet?.addToDailyRecord(record)
            
            StorageManager.shared.saveAll {[weak self] result in
                switch result {
                case .success:
                    self?.currentRecord?.append(record)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func modifyDailyRecord(date: Date, dailyRecord: PNDailyRecord) {
        showAddProtectPlanVC(date: date, dailyRecord: dailyRecord, title: "修改記錄") { date, event, describe in
            
            dailyRecord.date = date.timeIntervalSince1970
            dailyRecord.event = event
            dailyRecord.describe = describe
            
            StorageManager.shared.saveAll {[weak self] result in
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func showAddProtectPlanVC(date: Date, dailyRecord: PNDailyRecord, title: String, handler: @escaping (Date, [String], String) -> Void) {
        guard
            let addRecordVC = UIStoryboard.record.instantiateViewController(
            withIdentifier: String(describing: AddRecordViewController.self))
            as? AddRecordViewController
        else {
            return
        }
        
        addRecordVC.selecedDate = date
        addRecordVC.saveDateEvent = handler

        addRecordVC.setupNavigationTitle(title: title)
          
        show(addRecordVC, sender: nil)
    }
    
    @IBAction func addAction(_ sender: Any) {
        guard let day = calendar.selectedDate else {
            // 若沒有選擇日期直接使用當天日期
            guard
                let day = calendar.today
            else { return }
            
            addDailyRecord(date: day)
            return
        }
        addDailyRecord(date: day)
    }
}

extension RecordViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            default:
                return false
            }
        }
        
        return shouldBegin
    }
}

extension RecordViewController: FSCalendarDelegate {
    // 周顯示 / 月顯示
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    // 事件圓點顯示
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if eventDate.contains(date.getDateString(format: "yyyyMMdd")) {
            return 1
        } else {
            return 0
        }
    }
    
    // 被點選的日期
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        tableView.reloadData()
    }
    
}

extension RecordViewController: FSCalendarDataSource {
    
}

extension RecordViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let record = dateRecord[indexPath.row]
        
        StorageManager.shared.deleteData(record) {[weak self] result in
            switch result {
            case .success:
                self?.resetCurrentRecord()
                tableView.reloadData()
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
}

extension RecordViewController: UITableViewDataSource {
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateRecord.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DailyRecordTableViewCell.identifier,
                for: indexPath)
            as? DailyRecordTableViewCell
        else {
            return UITableViewCell()
        }
        
        let record = dateRecord[indexPath.row]
        let date = Date(timeIntervalSince1970: record.date)
        let describe = record.describe
        let events = record.event
        
        cell.layoutCell(date: date, describe: describe, events: events)
        return cell
    }
    
}
