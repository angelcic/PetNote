//
//  AlertView.swift
//  PetNote
//
//  Created by iching chen on 2019/10/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol AlertViewDelegate: AnyObject {
    func pressRightButton(_ viewController: AlertViewController)
    func pressLeftButton(_ viewController: AlertViewController)
}

class AlertViewController: BaseViewController {
    
    @IBOutlet weak var alertView: UIView! {
    didSet {
        alertView.addBorder(borderColor: .gray,
                             borderWidth: 1,
                             cornerRadius: 20)
        }
    }
    
    @IBOutlet weak var alertTextLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton! {
        didSet {
            leftButton.addCorner(cornerRadius: 5)
        }
    }
    
    @IBOutlet weak var rightButton: UIButton! {
        didSet {
            rightButton.addBorder(borderColor: .gray,
            borderWidth: 1,
            cornerRadius: 5)
        }
    }
    
    weak var delegate: AlertViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressLeftButtonAction() {
        delegate?.pressLeftButton(self)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressRightButtonAction() {
        delegate?.pressRightButton(self)
        self.dismiss(animated: false, completion: nil)
    }
}
