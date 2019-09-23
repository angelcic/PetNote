//
//  BasicInfoViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class BasicInfoViewController: UIViewController {
    
    var pet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}

extension BasicInfoViewController: UITableViewDelegate {
    
}

extension BasicInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
