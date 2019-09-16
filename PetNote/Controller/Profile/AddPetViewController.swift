//
//  AddPetViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/12.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol AddPetViewControllerDelegate: AnyObject {
    func addPetResult(_: Result<Void, Error>)
}

class AddPetViewController: BaseViewController {
    @IBOutlet weak var addPetLayer: UIView!
    
    @IBOutlet weak var addPetView: UIView! {
        didSet {
            addPetView.addBorder(borderColor: .gray,
                                 borderWidth: 1,
                                 cornerRadius: 20)
            if let petView = Bundle(for: AddPetView.self).loadNibNamed("\(AddPetView.self)",
                owner: nil,
                options: nil)?.first as? AddPetView {
                addPetView.addSubview(petView)
                petView.frame = addPetView.bounds
                petView.delegate = self
            }
        }
    }
    weak var delegate: AddPetViewControllerDelegate?
    
    let storageManager = StorageManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension AddPetViewController: AddPetViewDelegate {
    
    func cancelAction() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func confirmAction(name: String, type: PetType) {
//        guard let
        storageManager.addNewPet(name: name, type: type) {[weak self] result in
            
            switch result {
                
            case .success:
                print("success")
                
            case .failure(let error):
                print(error)
            }
            
            self?.delegate?.addPetResult(result)
            self?.dismiss(animated: false, completion: nil)
        }
       
    }
}
