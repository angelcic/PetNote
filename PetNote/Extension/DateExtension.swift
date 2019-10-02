//
//  DateExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/9/19.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

extension Date {
    func getDateString(format: String = "yyyy 年 MM 月 dd 日") -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        
        return dateFormat.string(from: self)
    }
}
