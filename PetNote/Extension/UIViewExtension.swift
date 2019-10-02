//
//  UIViewExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func addCorner(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }
}

extension UIView {
    func takeSnapshot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}
