//
//  DeseasePreventionViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class DeseasePreventionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
        
    }
    
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

extension DeseasePreventionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension DeseasePreventionViewController: UITableViewDelegate {
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

extension DeseasePreventionViewController: SectionHeaderDelegate {
    func pressAddButton() {
        print("+++")
    }   
    
}
