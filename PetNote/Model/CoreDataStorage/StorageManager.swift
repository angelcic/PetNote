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
        
        case hospital = "PNHospital"
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
    
    dynamic var petsList: [PNPetInfo] {
        
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
    
    func createDemoData(completion: ((Result<Void, Error>) -> Void)? = nil) {
        let pet = getPNPetInfo()
        pet.name = "卯咪（預設）"
        pet.petType = "喵"
        pet.gender = "女生"
        pet.birth = Int64(Date().timeIntervalSince1970)
        pet.petId = Int64(Date().timeIntervalSince1970)
        pet.breed = "米克斯"
        pet.color = "賓士"
        pet.id = "900000000000000"
        
        let protectPlan = getPNProtectPlan()
        protectPlan.protectName = "三合一"
        protectPlan.protectType = "疫苗"
        protectPlan.addToNotifyInfo(getPNNotifyInfo())
        pet.addToProtectPlan(protectPlan)        
        
        let protectPlan2 = getPNProtectPlan()
        protectPlan2.protectName = "寵愛"
        protectPlan2.protectType = "體外驅蟲"
        protectPlan2.addToNotifyInfo(getPNNotifyInfo())
        pet.addToProtectPlan(protectPlan2)        
        
        for index in 0...4 {
            let weightRecord = getPNPNWeightRecord()
            weightRecord.date = Int64(Date().timeIntervalSince1970) + Int64((86400 * index))
            weightRecord.weight = 2.5 + (Double(index) * 0.1)
            pet.addToWeightRecord(weightRecord)
        }
        let dailyRecord = getPNDailyRecord()
        dailyRecord.date = Date().timeIntervalSince1970
        dailyRecord.describe = "一餐吃了十個罐罐"
        dailyRecord.event = ["打噴嚏", "食慾不佳"]
        pet.addToDailyRecord(dailyRecord)
        
        saveAll(completion: completion)
    }
    
    // MARK: 修改
    
    // MARK: 刪除
    func deleteData(_ object: NSManagedObject, completion: ((Result<Void, Error>) -> Void)? = nil) {
        do {
            viewContext.delete(object)
            try viewContext.save()
            
            completion?(Result.success(()))
            
            //            fetchPets()
            
        } catch {
            
            completion?(Result.failure(error))
        }
    }
    
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
    
    func getPNPetInfo() -> PNPetInfo {
        return PNPetInfo.init(context: viewContext)
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
    
    func getPNNotifyInfo() -> PNNotifyInfo {
        let notifyInfo = PNNotifyInfo.init(context: viewContext)
        notifyInfo.isOpen = false
        notifyInfo.identifier = nil
        notifyInfo.date = Date().timeIntervalSince1970
        notifyInfo.time = Date().timeIntervalSince1970
        notifyInfo.repeatType = "不重複"
        notifyInfo.title = "預防計畫預定的日期到囉"
        return notifyInfo
    }
}

// MARK: Fetch hospital with same address
extension StorageManager {
    
    func featchHospitals(address: String, completion: ((Result<[PNHospital], Error>) -> Void)? = nil) {
        let request = NSFetchRequest<PNHospital>(entityName: Entity.hospital.rawValue)
        request.predicate = NSPredicate(format: "address == %@", address)
        
        do {
            
            let pnHospitalList = try viewContext.fetch(request)
                      
            if pnHospitalList.count > 0 {
                completion?(Result.success(pnHospitalList))
            } else {
                completion?(Result.failure(StorageError.emptyResult))
            }
            
        } catch {
            
            completion?(Result.failure(error))
        }
    }
    
    func getPNHospital() -> PNHospital {
        return PNHospital.init(context: viewContext)
    }
    
}

enum StorageError: Error {
    case emptyResult
}
