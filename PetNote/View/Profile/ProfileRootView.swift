//
//  ProfileRootView.swift
//  PetNote
//
//  Created by iching chen on 2019/8/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

class ProfileRootView: UIView {
    @IBOutlet weak var tableView: UITableView! {
        
        didSet {
            
            tableView.dataSource = self.delegate
            
            tableView.delegate = self.delegate
        }
    }
    
    weak var delegate: ProfileRootViewDelegate? {
        
        didSet {
            
            guard let tableView = tableView else { return }
            
            tableView.dataSource = self.delegate
            
            tableView.delegate = self.delegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.registerCellWithNib(
            identifier: String(describing: ProfileTableViewCell.self),
            bundle: nil
        )
    }

}

protocol ProfileRootViewDelegate: UITableViewDataSource, UITableViewDelegate, AnyObject {
   
}
