//
//  ThanksPageViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/26.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import SafariServices

class ThanksPageViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var thanksList: [String] = ["Asta Wu Illustration", "Icons8", "NSCalendar", "Charts"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "特別感謝"
        setupTableVew()
            // Do any additional setup after loading the view.
        }
        
        func setupTableVew() {
            tableView.registerCellWithNib(identifier: BasicWithRightButtonTableViewCell.identifier, bundle: nil)
        }
    
}

extension ThanksPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var urlString = ""
        switch indexPath.row {
        case 0:
            urlString = "https://dribbble.com/Astawu?fbclid=IwAR0gDw0oFt_sPVU9RdG07t0xDbWHZK3_aCEPB84ZQRsKRv7tUCk_CILF2oE"
            case 1:
            urlString = "https://icons8.com"
            case 2:
            urlString = "https://github.com/WenchaoD/FSCalendar"
            case 3:
            urlString = "https://github.com/danielgindi/Charts"
        default:
            return
        }
        guard let url = URL(string: urlString) else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
//        UIApplication.shared.open(url)
    }
}

extension ThanksPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thanksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: BasicWithRightButtonTableViewCell.identifier, for: indexPath)
            as? BasicWithRightButtonTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.hideMoreButton(isHidden: true)
        cell.layoutCell(title: thanksList[indexPath.row])
        
        return cell
    }
        
}
