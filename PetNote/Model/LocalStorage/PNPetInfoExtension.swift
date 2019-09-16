//
//  PNPetInfoExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/9/16.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

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
