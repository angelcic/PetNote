//
//  AddingProtectPlanViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol AddingProtectPlanVCDelegate: AnyObject {
    func pressAddProtectPlan(_ protectPlan: PNProtectPlan)
}

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
    
    weak var delegate: AddingProtectPlanVCDelegate?
    
    var protectPlan: PNProtectPlan = PNProtectPlan() {
        didSet {
            if let protectType = protectPlan.protectType {
                
                currentPreventType = ProtectType.getProtectType(name: protectType, petType: currentPetType)
                
                petPreventType = currentPreventType
            }
            if let protectPlan = protectPlan.protectName {
                petPlanNameString = protectPlan
            }
        }
    }
    
    var handler: ((PNProtectPlan) -> Void)?
    
    var petPlanNameString = ""
    // 
    var petPreventType: ProtectType?
    
    // 目前的寵物類型
    var currentPetType: PetType = .cat
    
    // 目前選擇的的計劃類型
    lazy var currentPreventType: ProtectType = .vaccines(type: currentPetType)
    
    // 目前選擇的計畫名稱
    var currentProtectPlanIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.backgroundColor = .white
        self.navigationItem.title = "添加預防計畫"
        
        setCollectionView()
        setTableView()
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        self.navigationController?.navigationBar.tintColor = .darkGray
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
        tableView.registerCellWithNib(identifier: String(describing: NotifyTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: TitleWithButtonTableViewCell.self), bundle: nil)
        
        tableView.registerHeaderWithNib(identifier: String(describing: WithImageSectionHeaderView.self), bundle: nil)
        
    }
    
    @objc func saveAction() {
        print("save")
        
        protectPlan.protectType = currentPreventType.protectTypeName
        
        if let cell =
            tableView.cellForRow(at: IndexPath(row: currentProtectPlanIndex, section: 0))
        as? ProtectTypeTableViewCell {
            if let text = cell.otherTextField.text, !text.isBlank {
                protectPlan.protectName = text
            } else {
                protectPlan.protectName = cell.titleLabel.text
            }
        }
        // TODO:

//        let notifyInfo = PNNotifyInfo()
//        notifyInfo.repeats = false
//        notifyInfo.date = 0
//
//        protectPlan.addToNotifyInfo(notifyInfo)
//        currentPet?.addToProtectPlan(protectPlan)
        
//        self.dismiss(animated: false, completion: nil)
//        delegate?.pressAddProtectPlan(protectPlan)
        handler?(protectPlan)
        navigationController?.popToRootViewController(animated: false)
        
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
        
        return CGSize(width: UIScreen.width / 5.0 - 6,
                      height: UIScreen.width / 5.0 - 6)
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

// TableView

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
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let notifySettingVC = UIStoryboard.notify.instantiateViewController(
                withIdentifier: String(describing: SettingNotifyViewController.self))
                as? SettingNotifyViewController
                else {
                    return
            }
            
            show(notifySettingVC, sender: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
}

extension AddingProtectPlanViewController: UITableViewDataSource {
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
                //                    cell.layoutTextField(title: petPlanNameString)
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

extension AddingProtectPlanViewController: TitleWithButtonTableViewCellDelegate {
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
