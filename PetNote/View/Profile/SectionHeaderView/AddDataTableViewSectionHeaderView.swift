//
//  AddDataTableViewSectionHeaderView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddDataTableViewSectionHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: SectionHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutHeaderView(title: String) {
        titleLabel.text = title
    }
    
    @IBAction func addAction(_ sender: Any) {
        delegate?.pressAddButton(self)
    }
}

protocol SectionHeaderDelegate: AnyObject {
    func pressAddButton(_ headerView: AddDataTableViewSectionHeaderView)
}
