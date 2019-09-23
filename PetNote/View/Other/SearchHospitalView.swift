//
//  SearchHospitalView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/7.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol  SearchHospitalViewDeleate: AnyObject {
    func pressSearchButton()
    
    func didChangeAddressData(city: String, district: String)
}

class SearchHospitalView: UIView {
    
    @IBOutlet weak var cityTextField: UITextField! {
        didSet {
            cityTextField.delegate = self
        }
    }
    @IBOutlet weak var districtTextField: UITextField! {
        didSet {
            districtTextField.delegate = self
        }
    }

    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.addCorner(cornerRadius: 8)
            searchButton.setTitleColor(.lightGray, for: .disabled)
        }
    }
    
    weak var delegate: SearchHospitalViewDeleate?
    
    func updateSearchButton(isEnable: Bool) {
        searchButton.isEnabled = isEnable
    }
    
    @IBAction func search() {
        delegate?.pressSearchButton()
    }

}

extension SearchHospitalView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            let city = cityTextField.text,
            let district = districtTextField.text
        else {
            return
        }
        
        delegate?.didChangeAddressData(city: city,
                                    district: district)
    }
}
