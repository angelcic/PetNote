//
//  BasicInfoViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class BasicInfoViewController: UIViewController {   
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var pet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: BasicInfoTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: AddImageTableViewCell.self), bundle: nil)
        
    }
}

extension BasicInfoViewController: AddImageTableViewCellDelegate {
    func pressAddImageButton() {
        print("加入照片")
    }
}

extension BasicInfoViewController: UITableViewDelegate {
    
}

extension BasicInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: AddImageTableViewCell.identifier,
                    for: indexPath)
                    as? AddImageTableViewCell
                else {
                    return UITableViewCell()
            }
            cell.delegate = self
            return cell
        default:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: BasicInfoTableViewCell.identifier,
                    for: indexPath)
                    as? BasicInfoTableViewCell
                else {
                    return UITableViewCell()
            }
            return cell
        }
        
    }
    
}
