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
    
    let symptoms: [String] = ["嘔吐", "拉肚子", "流眼淚", "打噴嚏", "精神不佳", "食慾不佳", "外傷"]
    
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
    
    @objc func saveAction() {
        
    }
}

extension AddRecordViewController: ProtectTypeTableViewCellDelegate {
    func checkAction(cell: ProtectTypeTableViewCell) {
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
            cell.layoutCell(title: symptoms[indexPath.row], hideTextField: true)
            return cell
        }
    }
}
