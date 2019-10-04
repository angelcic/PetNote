//
//  PNHospitalExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/10/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

extension PNHospital {
    func setupPNHospital(address: String, name: String, phone: String?, latitude: Double, longitude: Double) {
        self.address = address
        self.name = name
        self.phone = phone
        self.latitude = latitude
        self.longitude = longitude
    }
}
