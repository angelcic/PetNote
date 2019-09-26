//
//  AboutViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/25.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var url = ""
        switch indexPath.row {
        case 0:
            url = "https://www.privacypolicies.com/privacy/view/50656c70516f8f1b1de670eb85c8c16c"
        default:
            return
        }
        
        guard let aboutVC = storyboard?.instantiateViewController(
            withIdentifier: WebViewController.identifier) as? WebViewController else { return }
//
//        guard let type = StoreInfoType(rawValue: sender.tag) else { return }
//
//        setUrl(type: type)
        
        aboutVC.urlString = url
        
        show(aboutVC, sender: self)
        
    }
    
}

extension AboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
