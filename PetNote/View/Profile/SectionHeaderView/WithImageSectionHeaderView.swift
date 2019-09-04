//
//  WithImageSectionHeaderView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class WithImageSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutHeaderView(title: String) {
        titleLabel.text = title
    }
}
