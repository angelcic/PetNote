//
//  SearchHospitalResultViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/7.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SearchHospitalResultViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "附近醫院"
        setupTableView()
        // Do any additional setup after loading the view.
    }
        
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: HospitalDataTableViewCell.self), bundle: nil)
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        self.navigationController?.navigationBar.tintColor = .darkGray
        let saveButton = UIBarButtonItem(title: "MAP", style: .plain, target: self, action: #selector(showMap))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func showMap() {
        
    }
}

extension SearchHospitalResultViewController: UITableViewDelegate {
    
}

extension SearchHospitalResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: HospitalDataTableViewCell.self), for: indexPath)
            as? HospitalDataTableViewCell
        else {
            return UITableViewCell()
        }
        return cell
    }
    
}
