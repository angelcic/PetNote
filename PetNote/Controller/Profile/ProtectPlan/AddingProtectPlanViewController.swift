//
//  AddingProtectPlanViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddingProtectPlanViewController: BaseViewController {
    
    let protectPlans: [String] = ["疫苗", "體內驅蟲", "體外驅蟲", "其他"]
    let protectTypes: [ProtectType] = [.vaccines(type: .cat), .entozoa, .externalParasites(type: .cat), .other]
//    let catVaccines: [String] = ["三合一", "四合一", "五合一", "貓白血", "狂犬病", "其他"]
//    let dogVaccines: [String] = ["七合一", "八合一", "十合一", "萊姆病", "狂犬病", "其他"]
//
//    let entozoa: [String] = ["犬新寶", "寵愛", "貝脈心", "心疥爽", "其他"]
//
//    let catExternalParasites: [String] = ["蚤安", "寵愛", "蚤不到", "易撲蚤",  "心疥爽", "其他"]
//    let dogExternalParasites: [String] = ["益百分", "寵愛", "蚤不到", "易撲蚤", "心疥爽", "其他"]
    var currentPetType: PetType = .cat {
        didSet {
            print(123)
        }
    }
    
    lazy var currentPreventType: ProtectType = .vaccines(type: currentPetType)
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
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
        // TODO:

//        if let cell = collectionView.cellForItem(at: indexPath)
//                    as? BasicCollectionViewCell {
//            cell.changeSelectedStatus()
//        }
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
                cell.changeSelectedStatus(true)

            default:
                if indexPath.row == currentPreventType.protectFuntions.count - 1 {
                    cell.layoutCell(title: currentPreventType.protectFuntions[indexPath.row], hideTextField: false)
                } else {
                cell.layoutCell(title: currentPreventType.protectFuntions[indexPath.row], hideTextField: true)
                }
                if indexPath.row == 0 {
                    cell.changeSelectedStatus(true)
                } else {
                   cell.changeSelectedStatus(false)
                }
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
