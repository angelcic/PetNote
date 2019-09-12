//
//  StorageManager.swift
//  PetNote
//
//  Created by iching chen on 2019/9/11.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import CoreData

class StorageManager: NSObject {
    
    private enum Entity: String, CaseIterable {
        
        case info = "PNInfo"
        
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
    
    var petsList: [PNPetInfo] = []
    
    // MARK: 取得
    func fetchPets(completion: ((Result<[PNPetInfo], Error>) -> Void)? = nil) {
        let request = NSFetchRequest<PNPetInfo>(entityName: Entity.info.rawValue)
        
        do {
            
            let petsList = try viewContext.fetch(request)
            
            self.petsList = petsList
            
            completion?(Result.success(petsList))
            
        } catch {
            
            completion?(Result.failure(error))
        }
    }
    
    // MARK: 新增
    func addNewPet(name: String, type: PetType) {
        guard
            let entity =
            NSEntityDescription.entity(forEntityName: Entity.info.rawValue,
                                       in: viewContext)
        else {
            return
                
        }
        
        let pet = NSManagedObject(entity: entity,
                                  insertInto: viewContext)
        
        pet.setValue(name, forKey: "name")
        pet.setValue(type.rawValue, forKey: "petType")
        
        do {
            
            try viewContext.save()
            fetchPets()
            
        } catch let error {
            print(error)
        }
    }
    
    // MARK: 修改
    
    // MARK: 刪除
    
    // MARK: 儲存
    func saveAll(completion: (Result<Void, Error>) -> Void) {
        
        do {
            
            try viewContext.save()
            
            completion(Result.success(()))
            
            fetchPets()
            
        } catch {
            
            completion(Result.failure(error))
        }
    }
}
