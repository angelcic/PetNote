//
//  HospitalRequest.swift
//  PetNote
//
//  Created by iching chen on 2019/9/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

enum HospitalRequest: Request {
    
    case hospitalList(city: String, zip: String)
    
    var headers: [String: String] {
        
        switch self {
            
        case .hospitalList: return [:]
        }
    }
    
    var body: Data? {
        
        switch self {
        case .hospitalList: return nil
            
        }
    }
    
    var method: String {
        
        switch self {
            
        case .hospitalList: return PNHTTPMethod.GET.rawValue
            
        }
    }
    
    var endPoint: String {
        
        switch self {
            
        case .hospitalList(let city, let zip):
            return
        "縣市+like+\(city)+and+機構地址+like+\(zip)"
            
        }
        
    }
    
    var queryParameter: String? {
        
        switch self {
            
        case .hospitalList(let city, let zip):
            return
        "縣市+like+\(city)+and+機構地址+like+\(zip)"
            
        }
        
    }
    
}
