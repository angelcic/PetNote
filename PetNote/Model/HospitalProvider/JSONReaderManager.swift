//
//  JSONReaderManager.swift
//  PetNote
//
//  Created by iching chen on 2019/9/24.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

class JSONReaderManager {
    static let shared = JSONReaderManager()
    private init() {
        getTaiwanArea()
    }
    
    var taiwanArea: [TaiwanArea] = []
    
    func getTaiwanArea() {
        if let path = Bundle.main.path(forResource: "TaiwanArea", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                taiwanArea = try decoder.decode([TaiwanArea].self, from: data)
                
            } catch let error {
                print(error)
            }
        }
    }
    
}
