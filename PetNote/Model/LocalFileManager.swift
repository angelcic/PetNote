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
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    lazy var docURL = URL(string: documentDirectory)
    
    let imageDirectoryURL: URL = {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let docURL = URL(string: documentDirectory)!
        let imageFolderURL = docURL.appendingPathComponent("Resources", isDirectory: true)
        
        return imageFolderURL
    }()
    
//    let imageDirectoryPath: String = {
//        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        return url.absoluteString
//    }()
    
    private init() {
        
    }
    
    func saveImage(image: UIImage, completion: ((Result<String, Error>) -> Void)? = nil) {
        // 判斷存圖片的資料夾是否存在
        
        let isExist = FileManager.default.fileExists(atPath: imageDirectoryURL.absoluteString)
        
        if isExist {
            //        若有則進行存檔
            let filePath = imageDirectoryURL.appendingPathComponent(
                "\(Date().timeIntervalSince1970).jpg",
                isDirectory: false).absoluteString
            
            let imageData = image.fixedOrientation()!.jpegData(compressionQuality: 1)
            
            let result = FileManager.default.createFile(atPath: filePath, contents: imageData, attributes: nil)
            
            if result {
                print("圖片存取成功")
                completion?(Result.success(filePath))
            } else {
                print("圖片存取失敗")
                completion?(Result.failure(LocalFileIOError.saveFileError))
            }
            
        } else {
            //        若無則創建
            do {
                try FileManager.default.createDirectory(
                    atPath: imageDirectoryURL.absoluteString,
                    withIntermediateDirectories: true,
                    attributes: nil)
                // 創建成功繼續執行寫入檔案
                saveImage(image: image, completion: completion)
            } catch let error {
                print("創建檔案夾失敗")
                print(error.localizedDescription)
                completion?(Result.failure(LocalFileIOError.createFolderError))
                
            }
        }
    }
    
    func readImage(imagePath: String?, completion: ((Result<UIImage, Error>) -> Void)? = nil) -> UIImage? {
        
        guard let imagePath = imagePath else {
            return nil
        }
        
        if FileManager.default.fileExists(atPath: imagePath) {
            
            if let image = UIImage(contentsOfFile: imagePath) {
                
                completion?(Result.success(image))
                return image
            } else {
                completion?(Result.failure(LocalFileIOError.readFileError))
                return nil
            }
            
        } else {
            completion?(Result.failure(LocalFileIOError.pathNotFound))
            return nil
        }
    }
    
    func createFolder(path: String, completion: ((Result<Void, Error>) -> Void)? = nil) {
        do {
            try FileManager.default.createDirectory(
                atPath: path,
                withIntermediateDirectories: true,
                attributes: nil)
            completion?(Result.success(()))
        } catch let error {
            print("創建檔案夾失敗")
            print(error.localizedDescription)
            completion?(Result.failure(LocalFileIOError.createFolderError))
            
        }
    }
    
    enum LocalFileIOError: Error {
        case createFolderError
        case pathNotFound
        case readFileError
        case saveFileError
    }
}
