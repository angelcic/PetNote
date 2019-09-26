//
//  ViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

private enum Tab {
    case profile
    
    case record
    
//    case medical
    
    case other
    
    func controller() -> UIViewController {
        var controller: UIViewController
        
        switch self {
        case .profile: controller = UIStoryboard.profile.instantiateInitialViewController()!
        case .record: controller = UIStoryboard.record.instantiateInitialViewController()!
//        case .medical: controller = UIStoryboard.medical.instantiateInitialViewController()!
        case .other: controller = UIStoryboard.other.instantiateInitialViewController()!
        }
        
        controller.tabBarItem = tabBarItem()
       
        controller.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)],
            for: .normal)
        controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return controller
    }
    
    func tabBarItem() -> UITabBarItem {
        
//        let image = UIImage(named: "Icons_64px_footprint01")

        let image = UIImage(named: "Icon-foot-Small")
        
        switch self {
        case .profile:
            
//            image.res
            return UITabBarItem(
                title: "毛孩檔案",
                image: image,
                selectedImage: nil)
        case .record:
             return UITabBarItem(
                title: "症狀記錄",
                image: image,
                selectedImage: nil)
//        case .medical:
//             return UITabBarItem(
//                title: "就診記錄",
//                image: image,
//                selectedImage: nil)
        case .other:
             return UITabBarItem(
                title: "其他功能",
                image: image,
                selectedImage: nil)
        }
       
    }
    
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let tabs: [Tab] = [.profile, .record, .other]
//        [.profile, .record, .medical, .other]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewControllers = tabs.map({ $0.controller()
        })
        self.tabBar.tintColor = UIColor.pnBlueDark
//        self.tabBar.unselectedItemTintColor = UIColor.pnGray
        StorageManager.shared.fetchPets()
        
        delegate = self
    }

}
