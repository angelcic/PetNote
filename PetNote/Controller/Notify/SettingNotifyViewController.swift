//
//  SettingNotifyViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SettingNotifyViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.navigationItem.title = "通知設定"
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        let saveButton = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: SettingNotifyTableViewCell.self), bundle: nil)
        
    }
    
    @objc func saveAction() {
        guard let settingNotifyCell = tableView.visibleCells[0]
            as? SettingNotifyTableViewCell
        else {
            return
        }
        settingNotifyCell.getNotifySetting()
    }

}

extension SettingNotifyViewController: UITableViewDelegate {
    
}

extension SettingNotifyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingNotifyTableViewCell.identifier,
                for: indexPath)
        as? SettingNotifyTableViewCell
            else {
                return UITableViewCell()
        }
        
        return cell
    }
}
