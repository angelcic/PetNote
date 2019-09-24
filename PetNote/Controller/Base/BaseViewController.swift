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
//        self.view.backgroundColor = .pnWhite
        // Do any additional setup after loading the view.
    }
    
    // 設定 navigationbar 文字顏色、按鈕
    func navigationBarSetting() {
        // navigation bar tint color
        self.navigationController?.navigationBar.tintColor = .pnWhite
        
        // navigation bar back button text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // navigation bar 背景色
        self.navigationController?.navigationBar.barTintColor = .pnBlueDark
        
        // navigation bar title text color
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: (UIColor.pnWhite)!]
    }

}
