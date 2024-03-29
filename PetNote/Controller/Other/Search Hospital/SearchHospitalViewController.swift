//
//  SearchHospitalViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/7.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SearchHospitalViewController: BaseViewController {

    @IBOutlet weak var searchView: SearchHospitalView! {
        didSet {
            searchView.backgroundColor = .pnBlueDark
            searchView.addCorner(cornerRadius: 10)
            searchView.delegate = self
        }
    }
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView! {
        didSet {
            loadingView.isHidden = true
        }
    }
    
    var isSearchingFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "搜詢附近醫院"
    }
    
    func showSearchResultVC(hospitals: [Hospital]) {
       
        DispatchQueue.main.async { [weak self] in

            guard let searchResultVC = UIStoryboard.other.instantiateViewController(
                withIdentifier: String(describing: SearchHospitalResultViewController.self))
                as? SearchHospitalResultViewController
            else {
                return
            }
            
            searchResultVC.hospitalLists = hospitals
            self?.show(searchResultVC, sender: nil)
        }
        
    }
    
}

extension SearchHospitalViewController: SearchHospitalViewDeleate {
        
    func didChangeAddressData(_ view: SearchHospitalView, city: String, district: String) {
        guard
            !city.isBlank && !district.isBlank
        else {
            searchView.updateSearchButton(isEnable: false)
            return
        }
        searchView.updateSearchButton(isEnable: true)
    }
    
    func pressSearchButton(_ view: SearchHospitalView) {
        if isSearchingFlag == true { return }
        
        isSearchingFlag = true
        loadingView.isHidden = false
        loadingView.startAnimating()
        
        let city = searchView.cityTextField.text
        let district = searchView.districtTextField.text
        
        HospitalAPIManager.shared.fetchHospitals(city: city!,
                                                 zip: district!) {[weak self] result in
            
            DispatchQueue.main.async {
                self?.loadingView.isHidden = true
                self?.loadingView.stopAnimating()
            }
            
            self?.isSearchingFlag = false
            
            switch result {
            case .success(let hospitals):
                
                self?.showSearchResultVC(hospitals: hospitals)
                
            case .failure(let error):
                
                print(error)
            }
        }
        
    }
}
