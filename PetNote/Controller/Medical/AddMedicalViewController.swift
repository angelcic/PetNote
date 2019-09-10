//
//  AddMedicalViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddMedicalViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "添加用藥記錄"
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
        tableView.registerCellWithNib(identifier: String(describing: MedicalBasicTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: TitleWithButtonTableViewCell.self), bundle: nil)
        
//        tableView.registerHeaderWithNib(identifier: String(describing: WithImageSectionHeaderView.self), bundle: nil)
    }
    
    @objc func saveAction() {
        
    }

}
extension AddMedicalViewController: TitleWithButtonTableViewCellDelegate {
    func pressRightButton() {
        guard let notifySettingVC = UIStoryboard.notify.instantiateViewController(
            withIdentifier: String(describing: SettingNotifyViewController.self))
            as? SettingNotifyViewController
            else {
                return
        }
        
        show(notifySettingVC, sender: nil)
    }
}

extension AddMedicalViewController: UITableViewDelegate {
    
}

extension AddMedicalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: MedicalBasicTableViewCell.self),
                for: indexPath)
                as? MedicalBasicTableViewCell
            else {
                    return UITableViewCell()
            }
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: TitleWithButtonTableViewCell.self),
                for: indexPath)
                as? TitleWithButtonTableViewCell
                else {
                    return UITableViewCell()
            }
            cell.delegate = self
            cell.layoutCell(title: "通知管理", buttonTitle: "管理")
            return cell
        }
    }
}

extension AddMedicalViewController: MedicalBasicTableViewCellDelegate {
    
    var medicalTypes: [String] {
        return ["膠囊", "藥水", "眼藥", "藥膏", "其他"]
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: BasicCollectionViewCell.self),
                for: indexPath)
                as? BasicCollectionViewCell
        else {
                return UICollectionViewCell()
        }
        cell.layoutCell(title: medicalTypes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tableView.frame.width / 6, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
