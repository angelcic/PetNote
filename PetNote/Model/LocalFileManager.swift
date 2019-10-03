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
        print("照片檔案夾路徑： \(imageFolderURL.absoluteString)")
        return imageFolderURL
    }()
    
    private init() {
        
    }
    
    func saveImage(petId: String, image: UIImage, completion: ((Result<String, Error>) -> Void)? = nil) {
        // 判斷存圖片的資料夾是否存在
        
        let isExist = FileManager.default.fileExists(atPath: imageDirectoryURL.absoluteString)
        let photoName = "\(petId).jpg"
        if isExist {
            //        若有則進行存檔
            let filePath = imageDirectoryURL.appendingPathComponent(
                photoName,
                isDirectory: false
            ).absoluteString
            
            print("=======filePath = \(filePath)")
            let imageData = image.fixedOrientation()!.jpegData(compressionQuality: 1)
            
            let result = FileManager.default.createFile(
                atPath: filePath,
                contents: imageData,
                attributes: nil
            )
            
            if result {
                completion?(Result.success(photoName))
            } else {
                completion?(Result.failure(LocalFileIOError.saveFileError))
            }
            
        } else {
            // 若無則創建
            do {
                try FileManager.default.createDirectory(
                    atPath: imageDirectoryURL.absoluteString,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                
                // 創建成功繼續執行寫入檔案
                saveImage(petId: petId, image: image, completion: completion)
                
            } catch let error {
                // 創建檔案夾失敗
                print(error.localizedDescription)
                completion?(Result.failure(LocalFileIOError.createFolderError))
                
            }
        }
    }
    
    func readImage(fileName: String?, completion: ((Result<UIImage, Error>) -> Void)? = nil) -> UIImage? {
                
        guard let fileName = fileName else {
            return nil
        }
        
        let imagePath = imageDirectoryURL.appendingPathComponent(
            fileName,
            isDirectory: false
        ).absoluteString
        
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
                attributes: nil
            )
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
