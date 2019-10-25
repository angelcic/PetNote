//
//  Hospital.swift
//  PetNote
//
//  Created by iching chen on 2019/9/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

struct HospitalList: Codable {
    
}

struct Hospital: Codable {
    
    let name: String
    let address: String
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        
        case name = "機構名稱"
        case address = "機構地址"
        case phone = "機構電話"
    }
    
}
