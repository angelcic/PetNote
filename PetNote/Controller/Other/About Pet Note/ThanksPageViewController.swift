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
    
    var thanksList: [ThanksList] = [.asta, .icons8, .calendar, .charts, .freepik]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "特別感謝"
        setupTableVew()
    }
    
    func setupTableVew() {
        tableView.registerCellWithNib(
            identifier: BasicWithRightButtonTableViewCell.identifier,
            bundle: nil
        )
    }
    
}

extension ThanksPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = thanksList[indexPath.row].urlString
        guard let url = URL(string: urlString) else {return}
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
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
        cell.layoutCell(title: thanksList[indexPath.row].title)
        
        return cell
    }
        
}

enum ThanksList {
    case asta
    case icons8
    case calendar
    case charts
    case freepik
    
    var title: String {
        switch self {
        case .asta: return "Asta Wu Illustration"
        case .icons8: return "Icons8"
        case .calendar: return "NSCalendar"
        case .charts: return "Charts"
        case .freepik: return "freepik"
        }
    }
    
    var urlString: String {
        switch self {
        case .asta: return "https://dribbble.com/Astawu?fbclid=IwAR0gDw0oFt_sPVU9RdG07t0xDbWHZK3_aCEPB84ZQRsKRv7tUCk_CILF2oE"
        case .icons8: return "https://icons8.com"
        case .calendar: return "https://github.com/WenchaoD/FSCalendar"
        case .charts: return "https://github.com/danielgindi/Charts"
        case .freepik: return "https://www.freepik.com/free-photos-vectors/background"
        }
    }
}
