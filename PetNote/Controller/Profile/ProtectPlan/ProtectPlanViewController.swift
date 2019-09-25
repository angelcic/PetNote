//
//  DeseasePreventionViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProtectPlanViewController: BaseContainerViewController {
    func petDidChange() {
        guard
            let pet = currentPet,
            let protectPlan = pet.protectPlan?.sortedArray(
                using: [NSSortDescriptor(key: "protectType", ascending: false)])
                as? [PNProtectPlan]
        else {
            return
        }
        self.protectPlans = protectPlan
    }

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
        
    }
    
    var protectPlans: [PNProtectPlan] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        protectPlans = currentPet?.protectPlan?.allObjects as? [PNProtectPlan] ?? []
        // Do any additional setup after loading the view.
    }
    
    func setTableView() {
        tableView.registerHeaderWithNib(
            identifier: String(describing: AddDataTableViewSectionHeaderView.self),
            bundle: nil)
        tableView.registerCellWithNib(identifier: ProtectPlanTableViewCell.identifier, bundle: nil)
    }
    
    func addProtectPlan() {
        showAddProtectPlanVC(protectPlan: StorageManager.shared.getPNProtectPlan(),
                             title: "添加預防計畫") {[weak self] protectPlan in
            self?.currentPet?.addToProtectPlan(protectPlan)
            
            StorageManager.shared.saveAll {[weak self] result in
                switch result {
                case .success:
                    self?.protectPlans.append(protectPlan)
                    self?.tableView.reloadData()
                    print("成功加入預防計畫")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func modifyProtectPlan(protectPlan: PNProtectPlan) {
        showAddProtectPlanVC(protectPlan: protectPlan, title: "編輯預防計畫") { protectPlan in
            StorageManager.shared.saveAll {[weak self] result in
                switch result {
                case .success:
                    self?.tableView.reloadData()
                    print("成功修改預防計畫")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func showAddProtectPlanVC(protectPlan: PNProtectPlan, title: String, handler: @escaping (PNProtectPlan) -> Void) {
        guard let addPlanViewController = UIStoryboard.profile.instantiateViewController(
            withIdentifier: "AddPreventionPage")
            as? AddingProtectPlanViewController
            else {
                return
        }
        if let petType = currentPet?.getPetType() {
            addPlanViewController.currentPetType = petType
        }
        addPlanViewController.handler = handler
        addPlanViewController.delegate = self
        addPlanViewController.protectPlan = protectPlan
        addPlanViewController.setupNavigationTitle(title: title)
        
        show(addPlanViewController, sender: nil)
    }
    
}

extension ProtectPlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if protectPlans.count == 0 {
            alertView.isHidden = false
        } else {
            alertView.isHidden = true
        }
        return protectPlans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProtectPlanTableViewCell.identifier,
                for: indexPath)
                as? ProtectPlanTableViewCell
            else {
                return UITableViewCell()
        }
        let type = protectPlans[indexPath.row].protectType
        let name = protectPlans[indexPath.row].protectName
        
        cell.layoutCell(type: type, name: name)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ProtectPlanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: AddDataTableViewSectionHeaderView.identifier)
            as? AddDataTableViewSectionHeaderView
        else {
                return UIView()
        }
        headerView.delegate = self
        return headerView
    }
    
    // MARK: 修改預防計畫
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        modifyProtectPlan(protectPlan: protectPlans[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("刪除")
        let plan = protectPlans[indexPath.row]
        StorageManager.shared.deleteData(plan) {[weak self] result in
            switch result {
            case .success:
                self?.protectPlans.remove(at: indexPath.row)
                tableView.reloadData()
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
}

extension ProtectPlanViewController: SectionHeaderDelegate {
    // MARK: 新增預防計畫
    func pressAddButton() {
        addProtectPlan()
    }
}

extension ProtectPlanViewController: AddingProtectPlanVCDelegate {
    func pressAddProtectPlan(_ protectPlan: PNProtectPlan) {
        currentPet?.addToProtectPlan(protectPlan)
        
        StorageManager.shared.saveAll {[weak self] result in
            switch result {
            case .success:
                self?.protectPlans.append(protectPlan)
                self?.tableView.reloadData()
                print("成功加入預防計畫")
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
