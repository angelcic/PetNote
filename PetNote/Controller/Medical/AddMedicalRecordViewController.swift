//
//  AddMedicalRecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddMedicalRecordViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let sectionHeader: [String] = ["用藥提醒", "回診提醒", "備註"]
    let medical: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "添加就診記錄"
        setupTableView() 
        // Do any additional setup after loading the view.
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        self.navigationController?.navigationBar.tintColor = .darkGray
        let saveButton = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: BasicMedicalRecordTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: TitleWithDateTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: TitleWithButtonTableViewCell.self), bundle: nil)
        tableView.registerHeaderWithNib(identifier: String(describing: WithImageSectionHeaderView.self), bundle: nil)
    }
    
    @objc func saveAction() {
        
    }
    
}

extension AddMedicalRecordViewController: UITableViewDelegate {
    
}

extension AddMedicalRecordViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil}
        guard let
            header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: WithImageSectionHeaderView.self))
            as? WithImageSectionHeaderView
        else {
            return nil
        }
        if section == 1 {
            header.hideAddButton(false)
        } else {
            header.hideAddButton(true)
        }
        header.layoutHeaderView(title: sectionHeader[section - 1])
        
        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return medical.count
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicMedicalRecordTableViewCell.self), for: indexPath)
            as? BasicMedicalRecordTableViewCell
                else {
                    return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleWithButtonTableViewCell.self), for: indexPath)
                as? TitleWithButtonTableViewCell
                else {
                    return UITableViewCell()
            }
            return cell
        case 2:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleWithDateTableViewCell.self), for: indexPath)
                    as? TitleWithDateTableViewCell
                    else {
                        return UITableViewCell()
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleWithButtonTableViewCell.self), for: indexPath)
                    as? TitleWithButtonTableViewCell
                    else {
                        return UITableViewCell()
                }
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
}
