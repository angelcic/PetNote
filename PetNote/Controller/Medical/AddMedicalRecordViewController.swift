//
//  AddMedicalRecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AddMedicalRecordViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "添加就診記錄"
        
        print("=========")
        // Do any additional setup after loading the view.
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        self.navigationController?.navigationBar.tintColor = .darkGray
        let saveButton = UIBarButtonItem(title: "儲存", style: .plain, target: self, action: #selector(saveAction))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveAction() {
        
    }
    
}
