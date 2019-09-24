//
//  MedicalRecord.swift
//  PetNote
//
//  Created by iching chen on 2019/9/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

struct MedicalRecord {
    let hospitalName: String?
    let time: String?
    let reason: String?
    let medical: [Medical]?
    
    init(time: String? = nil) {
        hospitalName = nil
        self.time = time
        reason = nil
        medical = nil
    }
}

struct Medical {
    let name: String?
    let type: MedicalType?
    let discription: String?
}

enum MedicalType {
    case liquid // 藥水
    case pill // 藥丸
    case ointment // 藥膏
    case eyedrops // 眼藥水
}
