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
    var neuter: String
    
//    init(name: String, type: PetType) {
//       self.init(name: name, type: type,
//                 birth: nil, gender: nil,
//                 petId: nil, breed: nil,
//                 color: nil, photo: nil,
//                 neuter: "未結紮")
//
//    }
    
    init(name: String, type: PetType,
         birth: String? = nil, gender: String? = nil,
         petId: String? = nil, breed: String? = nil,
         color: String? = nil, photo: UIImage? = nil,
         neuter: String = "未結紮") {
        self.name = name
        self.type = type
        self.birth = birth
        self.gender = gender
        self.petId = petId
        self.breed = breed
        self.color = color
        self.photo = photo
        self.neuter = neuter
    }
}

enum PetType: String {
    case cat = "喵"
    case dog = "汪"
    case other = "其它"
    
    var defaultImage: UIImage? {
        switch self {
        case .cat:
            return UIImage(named: "default_cat")
        case .dog:
            return UIImage(named: "default_dog")
        case .other:
            return UIImage(named: "default_other")
        }
    }
    
}

enum Gender: String {
    case girl = "女生"
    case boy = "男生"
    
}

enum Neuter: String {
    case isNeuter = "已結紮"
    case unNeuter = "未結紮"
}

//swiftlint:disable identifier_name
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
//swiftlint:enable identifier_name
