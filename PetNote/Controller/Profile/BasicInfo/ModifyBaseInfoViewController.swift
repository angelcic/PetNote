//
//  ModifyBaseInfoViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/15.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ModifyBaseInfoViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.addCorner(cornerRadius: 30)
            tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var confirmModifyButton: UIButton! {
        didSet {
            confirmModifyButton.addCorner(cornerRadius: 30)
            confirmModifyButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: ModifyBasicInfoTableViewCell.identifier, bundle: nil)
    }
    
    @IBAction func closeAction() {
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func confirmModifyAction() {
        self.dismiss(animated: false, completion: nil)
        
    }
}

extension ModifyBaseInfoViewController: UITableViewDelegate {
    
}

extension ModifyBaseInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyBasicInfoTableViewCell", for: indexPath)
            as? ModifyBasicInfoTableViewCell
        else {
            return UITableViewCell()
        }
        return cell
    }
    
}
