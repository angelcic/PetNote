//
//  HospitalAPIManager.swift
//  PetNote
//
//  Created by iching chen on 2019/9/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

class HospitalAPIManager {
    
    static let shared = HospitalAPIManager()
    
    private init() {}
    
    let decoder = JSONDecoder()
    var hospitalList: [Hospital] = []
    
    func fetchHospitals(city: String, zip: String, resultHandler: @escaping (Result<[Hospital], Error>) -> Void) {
            
        HTTPClient.shared.httpRequest(request: HospitalRequest.hospitalList(city: city, zip: zip)) { result in
            
                switch result {
                    
                case .success(let data):
                    
                    let decoder = JSONDecoder()
                    //讓 decoder 自動把 SnakeCase 轉成 CamelCase
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let hospitals = try decoder.decode([Hospital].self, from: data)
                        print(hospitals)
                        resultHandler(Result.success(hospitals))
                        
                    } catch let error {
                        resultHandler(Result.failure(error))
                        print(error)
                    }
                    
                case .failure(let error):
                    resultHandler(Result.failure(error))
                    print(error)
            }
        }
    }    
    
}
