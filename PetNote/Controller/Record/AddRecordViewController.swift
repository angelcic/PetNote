//
//  AddRecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddRecordViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var selecedDate: Date = Date()
    var saveDateEvent: ((Date, [String], String) -> Void)?
    
    var descriptionText: String = ""
    var events: [String] = []
    
//    let symptoms: [String] = ["嘔吐", "拉肚子", "流眼淚", "打噴嚏", "精神不佳", "食慾不佳", "外傷"]
    let symptoms: [Event] = [Event(title: "嘔吐"), Event(title: "拉肚子"), Event(title: "流眼淚"), Event(title: "打噴嚏"), Event(title: "精神不佳"), Event(title: "食慾不佳"), Event(title: "外傷")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "添加症狀記錄"
        
        setupTableView() 
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        
        tableView.registerCellWithNib(identifier: String(describing: DateSelectTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: DescriptionTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: ProtectTypeTableViewCell.self), bundle: nil)
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        let saveButton = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    @objc func saveAction() {
        
        if let dateCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DateSelectTableViewCell {
            selecedDate = dateCell.getDate()
//            return
        }
        if let describeCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DescriptionTableViewCell {
            descriptionText = describeCell.getDescription()
//            return
        }
        events = []
        symptoms.forEach {
            if $0.isSelected {
                events.append($0.title)
            }
        }
        saveDateEvent?(selecedDate, events, descriptionText)
        
        navigationController?.popToRootViewController(animated: false)
        
    }
}

extension AddRecordViewController: ProtectTypeTableViewCellDelegate {
    func checkAction(cell: ProtectTypeTableViewCell) {
        guard
            let indexPath = tableView.indexPath(for: cell)
        else {
            return
        }
        symptoms[indexPath.row].changeSelectedStatus()
    }
}

extension AddRecordViewController: UITableViewDelegate {
    
}

extension AddRecordViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return symptoms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.section {
        case 0:
            if indexPath.row == 0 {
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: String(describing: DateSelectTableViewCell.self),
                        for: indexPath)
                    as? DateSelectTableViewCell
                else {
                    return UITableViewCell()
                }
                cell.layoutCell(eventDate: selecedDate)
                return cell
            } else {
                guard
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: String(describing: DescriptionTableViewCell.self),
                        for: indexPath)
                    as? DescriptionTableViewCell
                else {
                    return UITableViewCell()
                }
                return cell
            }
        default:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ProtectTypeTableViewCell.self),
                    for: indexPath)
                as? ProtectTypeTableViewCell
                else {
                    return UITableViewCell()
            }
            cell.delegate = self
            cell.layoutCell(title: symptoms[indexPath.row].title, hideTextField: true)
            return cell
        }
    }
}
