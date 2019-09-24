//
//  URLExtension.swift
//  PetNote
//
//  Created by iching chen on 2019/9/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
extension URL {
    
    static func initPercent(string: String) -> URL {
        let urlwithPercentEscapes = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: urlwithPercentEscapes!)
        return url!
    }
}
