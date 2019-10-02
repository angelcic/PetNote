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
    
    let aboutTypes: [String] = ["特別感謝", "隱私權政策", "版本："]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "關於毛孩手帳"
        setupTableVew()
        // Do any additional setup after loading the view.
    }
    
    func setupTableVew() {
        tableView.registerCellWithNib(identifier: BasicWithRightButtonTableViewCell.identifier, bundle: nil)
    }
}

extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            guard let thanksVC = storyboard?.instantiateViewController(
                withIdentifier: ThanksPageViewController.identifier) as? ThanksPageViewController else { return }
            
            show(thanksVC, sender: self)
            
            return
        case 1:
            let url = "https://www.privacypolicies.com/privacy/view/50656c70516f8f1b1de670eb85c8c16c"
            guard let aboutVC = storyboard?.instantiateViewController(
                withIdentifier: WebViewController.identifier) as? WebViewController else { return }
            aboutVC.urlString = url
            
            show(aboutVC, sender: self)
        default:
            return
        }

    }
    
}

extension AboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: BasicWithRightButtonTableViewCell.identifier, for: indexPath)
            as? BasicWithRightButtonTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.layoutCell(title: aboutTypes[indexPath.row])
        
        if indexPath.row == aboutTypes.count - 1 {
            let infoDictionary = Bundle.main.infoDictionary
            let shortVersion: String? = infoDictionary! ["CFBundleShortVersionString"] as? String
            let majorVersion = (shortVersion != nil) ? shortVersion! : "0.0"
            cell.layoutCell(title: "版本：\(majorVersion)")
            cell.hideMoreButton(isHidden: true)
        } else {
            cell.layoutCell(title: aboutTypes[indexPath.row])
            cell.hideMoreButton(isHidden: false)
        }

        return cell
    }
    
}
