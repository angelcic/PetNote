//
//  ProtectPlan.swift
//  PetNote
//
//  Created by iching chen on 2019/9/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

struct ProtectPlan {
}

enum ProtectType {
    case vaccines(type: PetType)
    case entozoa
    case externalParasites(type: PetType)
    case other
        
    var protectFuntions: [String] {
        switch self {
        case .vaccines(let type):
            if type == .cat {
                return ["三合一", "四合一", "五合一", "貓白血", "狂犬病", "其他"]
            } else if type == .dog {
                return ["七合一", "八合一", "十合一", "萊姆病", "狂犬病", "其他"]
            } else {
                return ["其他"]
            }
        case .entozoa:
            return ["犬新寶", "寵愛", "貝脈心", "心疥爽", "其他"]
        case .externalParasites(let type):
            if type == .cat {
                return ["蚤安", "寵愛", "蚤不到", "易撲蚤", "心疥爽", "其他"]
            } else if type == .dog {
                return ["益百分", "寵愛", "蚤不到", "易撲蚤", "心疥爽", "其他"]
            } else {
                return ["其他"]
            }
        case .other:
            return ["其他"]
        }
    }
}
