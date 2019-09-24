//
//  DailyRecord.swift
//  PetNote
//
//  Created by iching chen on 2019/9/24.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

class Event {
    let title: String
    var isSelected: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    func changeSelectedStatus() {
        if isSelected {
            isSelected = false
        } else {
            isSelected = true
        }
    }
}
