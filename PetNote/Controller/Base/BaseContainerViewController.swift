//
//  BaseContainerViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/16.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol ContainerViewControllerProtocol {
    func petDidChange()
}

typealias BaseContainerViewController = ContainerViewController & ContainerViewControllerProtocol

class ContainerViewController: UIViewController {

    var currentPet: PNPetInfo? {
        didSet {
            guard let controller = self as? BaseContainerViewController else {
                return
            }
            controller.petDidChange()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
