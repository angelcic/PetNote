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
            }
            if let protectPlan = protectPlan.protectName {
                currentPlanNameString = protectPlan
            }
        }
    }
    
    var currentPlanNameString = ""
    
    var currentPetType: PetType = .cat
    
    lazy var currentPreventType: ProtectType = .vaccines(type: currentPetType)
    
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
    
    func setCollectionView() {
        collectionView.registerCellWithNib(identifier: String(describing: BasicCollectionViewCell.self), bundle: nil)
    }
    
    func setTableView() {
        tableView.registerCellWithNib(identifier: String(describing: ProtectTypeTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: NotifyTableViewCell.self), bundle: nil)
        tableView.registerHeaderWithNib(identifier: String(describing: WithImageSectionHeaderView.self), bundle: nil)
        
    }
    
    @objc func saveAction() {
    // TODO:
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
//        let notifyInfo = PNNotifyInfo()
//        notifyInfo.repeats = false
//        notifyInfo.date = 0
//
//        protectPlan.addToNotifyInfo(notifyInfo)
//        currentPet?.addToProtectPlan(protectPlan)
        
        self.dismiss(animated: false, completion: nil)
        delegate?.pressAddProtectPlan(protectPlan)
        
//        StorageManager.shared.saveAll {[weak self] result in
//            switch result {
//            case .success:
//                self?.delegate?.pressAddProtectPlan()
//            case .failure(let error):
//                print(error)
//            }
//        }
        
    }
}

// colloectionView

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
        if indexPath.row == 0 {
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
//
//        if let cell = collectionView.cellForItem(at: indexPath)
//                    as? BasicCollectionViewCell {
//            cell.changeSelectedStatus()
//        }
        // TODO:
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 這邊要修改
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
           
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
               
                cell.layoutTextField(title: currentPlanNameString)
                
                cell.changeSelectedStatus(true)

            default:
                
                if indexPath.row == currentPreventType.protectFuntions.count - 1 {
                    cell.layoutCell(title: currentPreventType.protectFuntions[indexPath.row], hideTextField: false)
                } else {
                cell.layoutCell(title: currentPreventType.protectFuntions[indexPath.row], hideTextField: true)
                }
                
                if currentPlanNameString == currentPreventType.protectFuntions[indexPath.row] {
                    cell.changeSelectedStatus(true)
                } else {
                    cell.changeSelectedStatus(false)
                }
//                if indexPath.row == 0 {
//                    cell.changeSelectedStatus(true)
//                } else {
//                   cell.changeSelectedStatus(false)
//                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: NotifyTableViewCell.self),
                for: indexPath)
                as? NotifyTableViewCell
            else {
                return UITableViewCell()
            }
            return cell
        }
        
    }
    
}
