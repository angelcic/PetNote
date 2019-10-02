//
//  IntExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/9/16.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

extension Int {
    
    func getDate() -> Date {
        let timeInterval: TimeInterval = TimeInterval(self)
        let date: Date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
    
    // return yyyy年MM月dd日
    func getDateString(format: String = "yyyy 年 MM 月 dd 日") -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        
        return dateFormat.string(from: self.getDate())
    }
}
