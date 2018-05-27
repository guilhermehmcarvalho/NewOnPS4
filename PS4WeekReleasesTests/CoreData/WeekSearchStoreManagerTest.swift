//
//  WeekSearchStoreManagerTest.swift
//  PS4WeekReleasesTests
//
//  Created by Guilherme Carvalho on 26/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import XCTest
import CoreData
@testable import PS4WeekReleases

class WeekSearchStoreManagerTest: XCTestCase {

    var sut: WeekSearchStoreManager!

    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()

    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PS4WeekReleases", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        })

        return container
    }()

    func initStubs() {
        func insertReleaseDate(dateGreater: Double, dateSmaller: Double, data: Data) -> WeekSearchData? {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "WeekSearchData",
                                                                   into: mockPersistantContainer.viewContext)
            entity.setValue(dateGreater, forKey: "dateGreater")
            entity.setValue(dateSmaller, forKey: "dateSmaller")
            entity.setValue(data, forKey: "data")
            /*entity.dateGreater = dateGreater
            entity.dateSmaller = dateSmaller
            entity.data = data*/

            return entity as? WeekSearchData
        }

        _ = insertReleaseDate(dateGreater: 123, dateSmaller: 234, data: Data())
        _ = insertReleaseDate(dateGreater: 234, dateSmaller: 345, data: Data())

        do {
            try mockPersistantContainer.viewContext.save()
        } catch {
            print("create fakes error \(error)")
        }
    }

    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> =
            NSFetchRequest<NSFetchRequestResult>(entityName: "WeekSearchData")
        guard let objs = try? mockPersistantContainer.viewContext.fetch(fetchRequest) else { return }
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        try? mockPersistantContainer.viewContext.save()
    }

    override func setUp() {
        super.setUp()
        initStubs()
        sut = WeekSearchStoreManager(container: mockPersistantContainer)
        NotificationCenter.default.addObserver( self,
                                                selector: #selector(contextSaved(notification:)),
                                                name: NSNotification.Name.NSManagedObjectContextDidSave ,
                                                object: nil )
    }

    override func tearDown() {
        flushData()
        super.tearDown()
    }

    func contextSaved( notification: Notification ) {
        saveNotificationCompleteHandler?(notification)
    }

    var saveNotificationCompleteHandler: ((Notification)->Void)?

    func waitForSavedNotification(completeHandler: @escaping ((Notification)->Void) ) {
        saveNotificationCompleteHandler = completeHandler
    }

    func testInsertRelease() {
        let release = sut.insertReleaseDate(dateGreater: 456, dateSmaller: 567, data: Data())
        XCTAssertNotNil(release)
    }

    func testFetch() {
        let data = sut.fetch(dateGreater: 123, dateSmaller: 234)
        XCTAssertNotNil(data)
    }

    func testFetchInexistant() {
        let data = sut.fetch(dateGreater: 123, dateSmaller: 123)
        XCTAssertNil(data)
    }

    func testSave() {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }

        sut.insertReleaseDate(dateGreater: 345, dateSmaller: 567, data: Data())

        //Assert save is called via notification (wait)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
