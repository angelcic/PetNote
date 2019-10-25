//
//  BasicWithRightButtonTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/25.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol BasicWithRightButtonTableViewCellDelegate: AnyObject {
    func pressMoreButton(cell: UITableViewCell)
}

class BasicWithRightButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    weak var delegate: BasicWithRightButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(title: String) {
        titleLabel.text = title
    }
    
    func hideMoreButton(isHidden: Bool) {
        rightButton.isHidden = isHidden
    }
    
    @IBAction func pressMore() {
        delegate?.pressMoreButton(cell: self)
    }
}
