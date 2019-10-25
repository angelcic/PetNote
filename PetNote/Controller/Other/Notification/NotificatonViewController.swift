//
//  NotificatonViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/9.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class NotificatonViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var currentNotificationType: String = "疫苗通知"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        self.navigationItem.title = currentNotificationType
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(
            identifier: String(describing: TitleWithButtonTableViewCell.self),
            bundle: nil
        )
        tableView.registerHeaderWithNib(
            identifier: String(describing: WithImageSectionHeaderView.self),
            bundle: nil
        )
    }
}

extension NotificatonViewController: TitleWithButtonTableViewCellDelegate {
    
    func pressRightButton(_ cell: TitleWithButtonTableViewCell) {
        guard
            let notifySettingVC = UIStoryboard.notify.instantiateViewController(
                withIdentifier: String(describing: SettingNotifyViewController.self)
                )
                as? SettingNotifyViewController
        else {
            return
        }
        
        show(notifySettingVC, sender: nil)
    }
}

extension NotificatonViewController: UITableViewDelegate {
    
}

extension NotificatonViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: WithImageSectionHeaderView.self))
            as? WithImageSectionHeaderView
        else {
            return nil
        }
        
        headerView.layoutHeaderView(title: "小白的疫苗通知")
        headerView.hideAddButton(false)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int.random(in: Range<Int>(uncheckedBounds: (lower: 0, upper: 4)))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TitleWithButtonTableViewCell.self),
            for: indexPath)
        as? TitleWithButtonTableViewCell
        else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.layoutCell(title: "", buttonTitle: "管理")
        return cell
    }
    
}
