//
//  AddingProtectPlanViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddingProtectPlanViewController: BaseViewController {
    
    // protectPlan & notifySetting
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }
    
    // protectType
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    let protectPlans: [String] = ["疫苗", "體內驅蟲", "體外驅蟲", "其他"]
    
    lazy var protectTypes: [ProtectType] =
        [.vaccines(type: currentPetType), .entozoa, .externalParasites(type: currentPetType), .other]
   
    var protectPlan: PNProtectPlan = PNProtectPlan() {
        didSet {
            if let protectType = protectPlan.protectType {
                
                currentPreventType = ProtectType.getProtectType(name: protectType, petType: currentPetType)
                
                petPreventType = currentPreventType
            }
            
            if let protectPlan = protectPlan.protectName {
                petPlanNameString = protectPlan
            }
            
            if let notify = protectPlan.notifyInfo?.allObjects[0] as? PNNotifyInfo {
                petNotifyInfo = notify
            }
        }
    }
    
    // 由前頁傳入按下儲存後要執行的 closure （新增或修改）
    var handler: ((PNProtectPlan) -> Void)?
    
    // 預防計畫類型
    var petPreventType: ProtectType?
    
    // 預防計畫細項
    var petPlanNameString = ""

    // 預防計畫的通知
    var petNotifyInfo: PNNotifyInfo?
    
    // 目前的寵物類型
    var currentPetType: PetType = .cat
    
    // 目前選擇的的計劃類型
    lazy var currentPreventType: ProtectType = .vaccines(type: currentPetType)
    
    // 目前選擇的計畫名稱
    var currentProtectPlanIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "添加預防計畫"
        
        setCollectionView()
        setTableView()
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        let saveButton = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }    
    
    func setupAddProtectPlanVC(title: String, currentPreventType: ProtectType, protectPlan: ProtectPlan) {
        
    }
    
    func setupNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func setCollectionView() {
        collectionView.registerCellWithNib(identifier: String(describing: BasicCollectionViewCell.self), bundle: nil)
    }
    
    func setTableView() {
        
        tableView.registerCellWithNib(identifier: String(describing: ProtectTypeTableViewCell.self), bundle: nil)
        // section header
        tableView.registerHeaderWithNib(identifier: String(describing: WithImageSectionHeaderView.self), bundle: nil)
        // 通知
        tableView.registerCellWithNib(identifier: String(describing: SettingNotifyTableViewCell.self), bundle: nil)
    }
    
    @objc func saveAction() {
        print("save")
        
        protectPlan.protectType = currentPreventType.protectTypeName
        
        // 取得預防計畫
        if let cell =
            tableView.cellForRow(at: IndexPath(row: currentProtectPlanIndex, section: 0))
        as? ProtectTypeTableViewCell {
            if let text = cell.otherTextField.text, !text.isBlank {
                protectPlan.protectName = text
            } else {
                protectPlan.protectName = cell.titleLabel.text
            }
        }
        // 取得通知設定
        guard let cell =
            tableView.cellForRow(at: IndexPath(row: 0, section: 1))
                as? SettingNotifyTableViewCell
        else {
            navigationController?.popToRootViewController(animated: false)
            return
        }
        
        let notify = cell.getNotifySetting()
        
        NotifyManager.shared.createNotification(by: notify,
                                                with: petNotifyInfo?.identifier) {[weak self] result in
            guard
                let protectPlan = self?.protectPlan,
                let petNotifyInfo = self?.petNotifyInfo
            else { return }
                                                    
            switch result {
            case .success(let identifier, let notificationObject):
                print("petNotifyInfo 的 id 為: \(identifier)")
                petNotifyInfo.identifier = identifier
                petNotifyInfo.date = notificationObject.nextDate.timeIntervalSince1970
                petNotifyInfo.time = notificationObject.alertTime.timeIntervalSince1970
                petNotifyInfo.isOpen = notificationObject.isSwitchOn
                petNotifyInfo.repeatType = notificationObject.frequencyTypes
                petNotifyInfo.title = notificationObject.alertText
                
                self?.handler?(protectPlan)
            case .failure(let error):
                print(error)
                self?.handler?(protectPlan)
            }
        }
        
        navigationController?.popToRootViewController(animated: false)
        
    }
    
    func showOpenAlertVC() {
        guard let alertVC = UIStoryboard.basic.instantiateViewController(
            withIdentifier: AlertViewController.identifier)
            as? AlertViewController
            else {return}
        
        alertVC.delegate = self
        
        // 顯示樣式
        alertVC.modalPresentationStyle = UIModalPresentationStyle.custom
        
        self.present(alertVC, animated: false, completion: nil)
        
    }
}

// MARK: 處理通知設定
extension AddingProtectPlanViewController: AlertViewDelegate {
       
    func pressLeftButton() {
        if let bundleID = Bundle.main.bundleIdentifier,
            let url = URL(string: UIApplication.openSettingsURLString + bundleID) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func pressRightButton() {
        
    }

}

// MARK: colloectionView setting

extension AddingProtectPlanViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return protectPlans.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let
            cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BasicCollectionViewCell.identifier,
                for: indexPath)
                as? BasicCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        cell.layoutCell(title: protectPlans[indexPath.row])
        if indexPath.row == currentPreventType.protectTypeIndex {
            cell.setSelectedBG()
        }
        return cell
    }
    
}

extension AddingProtectPlanViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for cell in collectionView.visibleCells {
            if let cell = cell as? BasicCollectionViewCell {
                cell.changeSelectedStatus()
            }
        }
        
        currentPreventType = protectTypes[indexPath.row]
        tableView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
    
}

extension AddingProtectPlanViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        
        let padding: CGFloat = 6
        let numbersInRow: CGFloat = 5.0
        let itemWidth = UIScreen.width / numbersInRow - padding
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
}

// MARK: TableView setting

extension AddingProtectPlanViewController: ProtectTypeTableViewCellDelegate {
    func checkAction(cell: ProtectTypeTableViewCell) {
        
        currentProtectPlanIndex = tableView.indexPath(for: cell)?.row ?? 0
        
        for cell in tableView.visibleCells {
            if let cell = cell as? ProtectTypeTableViewCell {
                cell.changeSelectedStatus(false)
            }
        }        
        cell.changeSelectedStatus(true)
        
    }
}

extension AddingProtectPlanViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let sectionHeaderHeight = CGFloat(50)
            if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
            } else if scrollView.contentOffset.y >= sectionHeaderHeight {
                scrollView.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0)
            }
        }
    }
}

extension AddingProtectPlanViewController: UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            var sectionCount = currentPreventType.protectFuntions.count
            if sectionCount == 0 {
                sectionCount = 1
            }
            return sectionCount
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: String(describing: WithImageSectionHeaderView.self))
            as? WithImageSectionHeaderView
        else {return UIView()}
        if section == 0 {
            view.layoutHeaderView(title: "預防計畫")
        } else {
            view.layoutHeaderView(title: "提醒通知")
        }
        return view
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            return getprotectNameCell(tableView, cellForRowAt: indexPath)
            
        } else {
            // 通知提醒
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingNotifyTableViewCell.identifier,
                    for: indexPath)
                    as? SettingNotifyTableViewCell
            else {
                return UITableViewCell()
            }
            
            guard let notifyInfo = petNotifyInfo else {
                return cell
            }
            
            let notificationObject = createNotificationObject(by: notifyInfo)
            
            cell.delegate = self
            cell.layoutCell(notification: notificationObject)
            return cell
        }
        
    }
    
    func createNotificationObject(by pnNotifyInfo: PNNotifyInfo) -> NotificationObject {
        
        let nextDate = Date(timeIntervalSince1970: TimeInterval(pnNotifyInfo.date))
        let alertTime = Date(timeIntervalSince1970: TimeInterval(pnNotifyInfo.time))
        
        let notificationObject = NotificationObject(
            isSwitchOn: pnNotifyInfo.isOpen,
            frequencyTypes: pnNotifyInfo.repeatType ?? RepeatType.once.rawValue,
            nextDate: nextDate,
            alertTime: alertTime,
            alertText: pnNotifyInfo.title ?? "")
        
        return notificationObject
    }
    
    func getprotectNameCell(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ProtectTypeTableViewCell.self),
                for: indexPath)
                as?  ProtectTypeTableViewCell
        else {
            return  UITableViewCell()
        }
        cell.delegate = self
        
        switch currentPreventType {
        case .other:
            
            cell.layoutCell(title: currentPreventType.protectFuntions[indexPath.row], hideTextField: false)
            
            if let petPreventType = petPreventType,
                petPreventType == currentPreventType {
                cell.layoutTextField(title: petPlanNameString)
            }
            
            cell.changeSelectedStatus(true)
            
        default:
            
            if indexPath.row == currentPreventType.protectFuntions.count - 1 {
                cell.layoutCell(title: currentPreventType.protectFuntions[indexPath.row], hideTextField: false)
            } else {
                cell.layoutCell(title: currentPreventType.protectFuntions[indexPath.row], hideTextField: true)
            }
            
            if let petPreventType = petPreventType,
                petPreventType == currentPreventType {
                if petPlanNameString == currentPreventType.protectFuntions[indexPath.row] {
                    cell.changeSelectedStatus(true)
                } else {
                    cell.changeSelectedStatus(false)
                }
                //  cell.layoutTextField(title: petPlanNameString)
            } else {
                if indexPath.row == 0 {
                    cell.changeSelectedStatus(true)
                } else {
                    cell.changeSelectedStatus(false)
                }
            }
        }
        return cell
    }
    
}

extension AddingProtectPlanViewController: SettingNotifyTableViewCellDelegate {
    func alertUserOpenNotification() {
        showOpenAlertVC()
    }
}
