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
}
