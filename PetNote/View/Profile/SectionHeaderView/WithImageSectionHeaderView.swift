//
//  WithImageSectionHeaderView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class WithImageSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: WithImageSectionHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hideAddButton(true)
    }
    
    func hideAddButton(_ isHidden: Bool) {
        addButton.isHidden = isHidden
    }
    
    func layoutHeaderView(title: String) {
        titleLabel.text = title
    }
    
    @IBAction func addAction(_ sender: Any) {
        delegate?.pressAddButton()
    }
}

protocol WithImageSectionHeaderDelegate: AnyObject {
    func pressAddButton()
}
