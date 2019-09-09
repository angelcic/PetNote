//
//  SearchHospitalViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/7.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SearchHospitalViewController: BaseViewController {

    @IBOutlet weak var searchView: UIView! {
        didSet {
            guard let searchView = searchView as? SearchHospitalView else { return }
            searchView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "搜詢附近醫院"
    }
    
}

extension SearchHospitalViewController: SearchHospitalViewDeleate {
    func pressSearchButton() {
        guard let SearchResultVC = UIStoryboard.other.instantiateViewController(withIdentifier: String(describing: SearchHospitalResultViewController.self)) as? SearchHospitalResultViewController
            else {
            return
        }
        show(SearchResultVC, sender: nil)
    }
}
