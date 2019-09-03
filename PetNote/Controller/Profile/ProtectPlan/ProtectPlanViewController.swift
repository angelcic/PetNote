//
//  DeseasePreventionViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProtectPlanViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
        
    }
    
    var protectPlan: [ProtectPlan] = []
    
    @IBOutlet weak var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        // Do any additional setup after loading the view.
    }
    
    func setTableView() {
        tableView.registerHeaderWithNib(
            identifier: String(describing: AddDataTableViewSectionHeaderView.self),
            bundle: nil)
    }
    
}

extension ProtectPlanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if protectPlan.count == 0 {
            alertView.isHidden = false
        } else {
            alertView.isHidden = true
        }
        return protectPlan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddDataTableViewSectionHeaderView.identifier) as? AddDataTableViewSectionHeaderView
        else {
                return UIView()
        }
        headerView.delegate = self
        return headerView
    }
}

extension ProtectPlanViewController: SectionHeaderDelegate {
    func pressAddButton() {
        
        guard let AddPlanViewController = UIStoryboard.profile.instantiateViewController(
            withIdentifier: "AddPreventionPage")
            as? AddingProtectPlanViewController
        else {
            return
        }
        
        show(AddPlanViewController, sender: nil)
        
    }   
    
}
