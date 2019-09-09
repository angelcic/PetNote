//
//  SearchHospitalView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/7.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class SearchHospitalView: UIView {

    @IBOutlet weak var searchButton: UIButton!
    
    weak var delegate: SearchHospitalViewDeleate?
    
    @IBAction func search() {
        delegate?.pressSearchButton()
    }

}

protocol  SearchHospitalViewDeleate: AnyObject {
    func pressSearchButton()
}
