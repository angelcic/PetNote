//
//  StorageManager.swift
//  PetNote
//
//  Created by iching chen on 2019/9/11.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objcMembers class StorageManager: NSObject {
    
    private enum Entity: String, CaseIterable {
        
        case info = "PNPetInfo"
        
        case protectPlan = "PNProtectPlan"
        
        case weightRecord = "PNWeightRecord"
        
        case medicalRecord = "PNMedicalRecord"
        
        case dailyRecord = "PNDailyRecord"
    }
    
    static let shared = StorageManager()
    
    private override init() {
        
        print(" Core data file path: \(NSPersistentContainer.defaultDirectoryURL())")
    }
    
    lazy var persistanceContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PetNote")
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        
        return persistanceContainer.viewContext
    }
    
    var petsList: [PNPetInfo] {
        
        return datas.map({ $0.info })
    }
    
    dynamic var datas: [PetInfo] = []
    
    var images: [UIImage?] {
        
        return datas.map({ $0.image })
    }
    
    dynamic var currentPetIndex: Int = 0
    
    // MARK: 取得
    func fetchPets(completion: ((Result<[PNPetInfo], Error>) -> Void)? = nil) {
        let request = NSFetchRequest<PNPetInfo>(entityName: Entity.info.rawValue)
        
        do {
            
            let petsList = try viewContext.fetch(request)
            
            self.datas = petsList.map({ PetInfo(info: $0) })
            
            completion?(Result.success(petsList))
            
        } catch {
            
            completion?(Result.failure(error))
        }
    }
    
    func addKVONotification() {
        self.didChangeValue(forKey: "currentPetIndex")
    }
    
    // MARK: 新增
    func addNewPet(petId: Double, name: String, type: PetType, completion: ((Result<Int, Error>) -> Void)? = nil) {
        guard
            let entity =
            NSEntityDescription.entity(forEntityName: Entity.info.rawValue, in: viewContext)
        else {
            return                
        }
        
        guard let pet = NSManagedObject(entity: entity,
                                  insertInto: viewContext)
            as? PNPetInfo else { return }
        pet.petId = Int64(petId)
        pet.name = name
        pet.petType = type.rawValue
//        pet.setValue(name, forKey: PetKey.name.rawValue)
//        pet.setValue(type.rawValue, forKey: PetKey.petType.rawValue)
        
        do {
            
            try viewContext.save()
//            fetchPets()
            datas.append(PetInfo(info: pet))
            completion?(Result.success(petsList.count - 1))
        } catch let error {
            print(error)
            completion?(Result.failure(error))
        }
        
    }
    
    // MARK: 修改
    
    // MARK: 刪除
    func deleteCurrentPet(completion: ((Result<Void, Error>) -> Void)? = nil) {
        deletePet(at: currentPetIndex, completion: completion)
    }
    
    func deletePet(at index: Int, completion: ((Result<Void, Error>) -> Void)? = nil) {
            
        do {
            viewContext.delete(petsList[index])
            datas.remove(at: index)
            try viewContext.save()
            
            completion?(Result.success(()))
            
            //            fetchPets()
            
        } catch {
            
            completion?(Result.failure(error))
        }
    }
    
    // MARK: 儲存
    func saveAll(completion: ((Result<Void, Error>) -> Void)? = nil) {
        
        do {
            
            try viewContext.save()
            
            completion?(Result.success(()))
            
//            fetchPets()
            
        } catch {
            
            completion?(Result.failure(error))
        }
    }
    
    func getPNProtectPlan() -> PNProtectPlan {
        return PNProtectPlan.init(context: viewContext)
    }
    
    func getPNPNWeightRecord() -> PNWeightRecord {
        return PNWeightRecord.init(context: viewContext)
    }
    
    func getPNDailyRecord() -> PNDailyRecord {
        return PNDailyRecord.init(context: viewContext)
    }
}
