//
//  BaseViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
        
    static var identifier: String {
        
        return String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        // Do any additional setup after loading the view.
    }
    
    // 設定 navigationbar 文字顏色、按鈕
    func navigationBarSetting() {
        self.navigationController?.navigationBar.tintColor = .darkGray
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
