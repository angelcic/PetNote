//
//  PetNoteTests.swift
//  PetNoteTests
//
//  Created by iching chen on 2019/10/14.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import XCTest
import CoreData

@testable import PetNote

class PetNoteTests: XCTestCase {
    
    var storageManager: StorageManager!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetNote", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
//        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (_, error) in

            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    override func setUp() {
        super.setUp()
        initStubs()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        flushData() 
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetch() {
        storageManager = StorageManager(container: mockPersistantContainer)
        
        storageManager.fetchPets()
        
        XCTAssertEqual(storageManager.petsList.count, 1)
    }
    
    func testFetchPets() {
        
        let container = MockPersistentContainer(name: "PetNote", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        //        description.shouldAddStoreAsynchronously = false
                
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (_, error) in

            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        
        storageManager = StorageManager(container: container)
        
        storageManager.fetchPets()
        
        guard let viewContext = container.viewContext as? MockViewContext else {

            XCTFail("123")

            return
        }
        
        XCTAssertEqual(viewContext.request?.entityName, "PNPetInfo")
        XCTAssertNotNil(viewContext.request, "Request should not be nil")
        
//        XCTAssertEqual(storageManager.petsList.count, 1)
    }
    
    func testAddNewPet() {
        
    }
    
    func testDeleteData() {
        
    }

}

extension PetNoteTests {
    func initStubs() {
        
        func addNewPet(petId: Double, name: String, type: PetType) -> NSManagedObject? {
            guard
                let entity = NSEntityDescription.entity(
                    forEntityName: "PNPetInfo",
                    in: mockPersistantContainer.viewContext),
                let pet = NSManagedObject(
                    entity: entity,
                    insertInto: mockPersistantContainer.viewContext)
                    as? PNPetInfo
            else {
                return nil
            }
            
            pet.setValue(Int64(petId), forKey: PetKey.name.rawValue)
            pet.setValue(name, forKey: PetKey.name.rawValue)
            pet.setValue(type.rawValue, forKey: PetKey.petType.rawValue)
            
            return pet
        }
        
        _ = addNewPet(petId: Date().timeIntervalSince1970, name: "阿花", type: .cat)
                
        do {
            try mockPersistantContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func flushData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest<NSFetchRequestResult>(entityName: "PNPetInfo")
        
        do {
            let objs = try mockPersistantContainer.viewContext.fetch(fetchRequest)
            for case let obj as NSManagedObject in objs {
                mockPersistantContainer.viewContext.delete(obj)
            }
        } catch let error {
            print(error)
        }
        do {
            try mockPersistantContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }

}

class MockPersistentContainer: NSPersistentContainer {
    let mockViewContext = MockViewContext()
    
    override var viewContext: NSManagedObjectContext {
        return mockViewContext
    }
    
}

class MockViewContext: NSManagedObjectContext {
    
    var request: NSFetchRequest<NSFetchRequestResult>?
    
    override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        
        self.request = request
        
//        return try super.fetch(request)
        return []
    }
}
