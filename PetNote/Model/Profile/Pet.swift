//
//  Pet.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

struct Pet {
    let name: String
    let type: PetType
    let color: String?
    let gender: String?
    let birth: String?
    let breed: String?
}

enum PetType {
    case cat
    case dog
    case other
}
