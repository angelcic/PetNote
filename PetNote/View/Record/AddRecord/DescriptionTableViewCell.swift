//
//  DescriptionTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.delegate = self
            descriptionTextView.addBorder(borderColor: .white, borderWidth: 1, cornerRadius: 20)
        }
    }
    
    @IBOutlet weak var backgroundBorderView: UIView! {
        didSet {
            backgroundBorderView.addBorder(borderColor: .gray, borderWidth: 1, cornerRadius: 20)
        }
    }
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getDescription() -> String {
        return descriptionTextView.text
    }
    
}

extension DescriptionTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text,
            !text.isEmpty && !text.isBlank
        else {
            placeHolderLabel.isHidden = false
            return
        }
        placeHolderLabel.isHidden = true    }
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = true
    }
}
