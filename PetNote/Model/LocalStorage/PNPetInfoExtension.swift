//
//  PNPetInfoExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/9/16.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

@objcMembers class PetInfo: NSObject {
    
    let info: PNPetInfo
    
    var image: UIImage?
    
    private var observation: NSKeyValueObservation!
    
    init(info: PNPetInfo) {
        self.info = info
        super.init()
        
        self.triggerObservation()
        
    }
    
    func triggerObservation() {
        
        observation = info.observe(\.photo, options: [.initial, .new]) { [weak self] (object, change) in
            
            guard let newValue = change.newValue else { return }
            //                print(change)
            self?.image = LocalFileManager.shared.readImage(imagePath: newValue)
        }
    }
}

extension PNPetInfo {
    
    func getPetType() -> PetType {
        
        guard let petType = petType else { return .cat }
        
        return PetType(rawValue: petType) ?? .cat
    }
    
    func getGender() -> Gender {
        
        guard let gender = gender else { return .girl }
        
        return Gender(rawValue: gender) ?? .girl
    }
    
    func getBirth() -> String {        
        if birth != 0 {
            return Int(birth).getDateString()
        } else {
            return ""
        }
    }
}
