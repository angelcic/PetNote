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
            cityTextField.inputView = cityPicker
        }
    }
    @IBOutlet weak var districtTextField: UITextField! {
        didSet {
            districtTextField.delegate = self
            districtTextField.inputView = districtPicker
        }
    }

    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.addCorner(cornerRadius: 8)
            searchButton.setTitleColor(.lightGray, for: .disabled)
            searchButton.setTitleColor(UIColor.pnBlueDark, for: .normal)
        }
    }
    
    weak var delegate: SearchHospitalViewDeleate?
    
    var cityPicker = UIPickerView()
    var districtPicker = UIPickerView()
    var curretIndex: Int = 0
    var taiwanArea = JSONReaderManager.shared.taiwanArea
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityPicker.delegate = self
        districtPicker.delegate = self
        cityPicker.dataSource = self
        districtPicker.dataSource = self
    }
    
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

extension SearchHospitalView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case cityPicker:
            curretIndex = row
            if cityTextField.text != taiwanArea[row].city {
                cityTextField.text = taiwanArea[row].city
                districtTextField.text = ""
            }
        case districtPicker:
            districtTextField.text = taiwanArea[curretIndex].district[row]
        default:
            return
        }
    }
}

extension SearchHospitalView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case cityPicker:
            return taiwanArea.count
        case districtPicker:
            return taiwanArea[curretIndex].district.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case cityPicker:
            return taiwanArea[row].city
        case districtPicker:
            return taiwanArea[curretIndex].district[row]
        default:
            return ""
        }
    }
    
}
