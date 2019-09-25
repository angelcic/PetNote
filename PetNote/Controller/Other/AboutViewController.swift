//
//  AboutViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/25.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableVew()
        // Do any additional setup after loading the view.
    }
    
    func setupTableVew() {
        tableView.registerCellWithNib(identifier: BasicWithRightButtonTableViewCell.identifier, bundle: nil)
    }
}

extension AboutViewController: UITableViewDelegate {
    
}

extension AboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: BasicWithRightButtonTableViewCell.identifier, for: indexPath)
            as? BasicWithRightButtonTableViewCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}

