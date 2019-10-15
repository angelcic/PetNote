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
        let managedObjectModel = NSManagedObjectModel.mergeModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetNote", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
//        description.shouldAddStoreAsynchronously = false
        
        container.loadPersistentStores(completionHandler: { (_, error) in

            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    override func setUp() {
        super.setUp()
        storageManager = StorageManager(container: mockPersistantContainer)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

extension PetNoteTests {
    func init
}
