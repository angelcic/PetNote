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

//"縣市": " 臺北市",
//"字號": " 北市獸業字第557號",
//"執照類別": " 獸醫師",
//"狀態": " 開業",
//"機構名稱": " 喜樂動物醫院",
//"負責獸醫": " 陳正倫",
//"機構電話": " 02-27324986",
//"發照日期": " 2019/07/25",
//"機構地址": " 臺北市大安區基隆路2段118號2樓"
