//
//  Pet.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

struct Pet {
    let name: String
    var birth: String?
    let type: PetType
    var gender: String?
    var petId: String?
    var breed: String?
    var color: String?
    var photo: UIImage?
    
    init(name: String, type: PetType) {
       self.init(name: name, type: type,
                 birth: nil, gender: nil,
                 petId: nil, breed: nil,
                 color: nil, photo: nil)
        
    }
    
    init(name: String, type: PetType,
         birth: String?, gender: String?,
         petId: String?, breed: String?,
         color: String?, photo: UIImage?) {
        self.name = name
        self.type = type
        self.birth = birth
        self.gender = gender
        self.petId = petId
        self.breed = breed
        self.color = color
        self.photo = photo
    }
}

enum PetType: String {
    case cat
    case dog
    case other
    
    static func getPetType(with index: Int) -> PetType {
        switch index {
        case 0:
            return .cat
        case 1:
            return .dog
        case 2:
            return .other
        default:
            return .cat
        }
    }
    
    func getPetTypeIndex() -> Int {
        switch self {
        case .cat:
            return 0
        case .dog:
            return 1
        case .other:
            return 2
        }
    }
}

enum Gender: String {
    case girl = "女生"
    case boy = "男生"
    
    static func getGender(with text: String) -> Gender {
        let type = Gender(rawValue: text)
        return type ?? .girl
    }
    
    static func getGender(with index: Int) -> Gender {
        
        switch index {
        case 0:
            return .girl
        case 1:
            return .boy
        default:
            return .girl
        }
    }
    
    func getGenderIndex() -> Int {
        switch self {
        case .girl:
            return 0
        case .boy:
            return 1
        }
    }
}

enum PetKey: String {
    case name
    case birth
    case petType
    case gender
    case id
    case breed
    case color
    case photo
    case pnId
}
