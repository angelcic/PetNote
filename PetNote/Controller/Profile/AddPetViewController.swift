//
//  AddPetViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/12.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol AddPetViewControllerDelegate: AnyObject {
    func addPetResult(_ viewController: AddPetViewController?, _: Result<Int, Error>)
}

class AddPetViewController: BaseViewController {
    @IBOutlet weak var addPetLayer: UIView!
    
    @IBOutlet weak var addPetView: UIView! {
        didSet {
            addPetView.addBorder(borderColor: .gray,
                                 borderWidth: 1,
                                 cornerRadius: 20)
            
            guard let petView = Bundle(for: AddPetView.self).loadNibNamed("\(AddPetView.self)", owner: nil, options: nil)?.first
                as? AddPetView
            else {
                return
            }
            
            addPetView.addSubview(petView)
            petView.frame = addPetView.bounds
            petView.delegate = self
            
        }
    }
    weak var delegate: AddPetViewControllerDelegate?
    
    let storageManager = StorageManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension AddPetViewController: AddPetViewDelegate {
    
    func cancelAction(_ view: AddPetView) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func confirmAction(_ view: AddPetView, petId: Double, name: String, type: PetType) {

        storageManager.addNewPet(petId: petId, name: name, type: type) {[weak self] result in
            
            switch result {
                
            case .success(let index):
                self?.storageManager.currentPetIndex = index
                
            case .failure(let error):
                print(error)
            }
            
            self?.delegate?.addPetResult(self, result)
            self?.dismiss(animated: false, completion: nil)
        }
       
    }
}
