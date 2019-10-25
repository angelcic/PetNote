//
//  StringExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/9/14.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

extension String {
    var isBlank: Bool {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
    }
}
