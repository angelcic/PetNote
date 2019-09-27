//
//  DeletePetViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/27.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol DeletePetViewControllerDelegate: AnyObject {
    func pressConfirmDeleteButton()
}

class DeletePetViewController: BaseViewController {
    @IBOutlet weak var addPetLayer: UIView!
    
    @IBOutlet weak var addPetView: UIView! {
    didSet {
        addPetView.addBorder(borderColor: .gray,
                             borderWidth: 1,
                             cornerRadius: 20)
        }
    }
    
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.addCorner(cornerRadius: 5)
        }
    }
    
    @IBOutlet weak var confirmDeleteButton: UIButton! {
        didSet {
            confirmDeleteButton.addBorder(borderColor: .gray,
            borderWidth: 1,
            cornerRadius: 5)
        }
    }
    
    weak var delegate: DeletePetViewControllerDelegate?
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }    
    
    @IBAction func cancel() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func confirmDelete() {
        delegate?.pressConfirmDeleteButton()
        self.dismiss(animated: false, completion: nil)
    }
}
