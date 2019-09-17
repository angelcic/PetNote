//
//  LocalFileManager.swift
//  PetNote
//
//  Created by iching chen on 2019/9/17.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    let imageDirectoryPath: String = {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return url.absoluteString
    }()
    
    private init() {
        
    }
    
    func saveImage(image: UIImage) {
        // 判斷存圖片的資料夾是否存在
        let path = imageDirectoryPath + "/images"
        let isExist = FileManager.default.fileExists(atPath: path)
        
        if isExist {
            //        若有則進行存檔
            if let dataToSave = image.pngData() {
                let filePath = path + "test.png"
                let fileURL = URL(fileURLWithPath: filePath)
                
                do {
                    try dataToSave.write(to: fileURL)
                    // TODO: 存檔
                } catch {
                    print("圖片存檔失敗")
                }
            }
        } else {
            //        若無則創建
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                saveImage(image: image)
            } catch {
                print("創建檔案夾失敗")
            }
        }
    }
}
