//
//  ReleaseDateStoreManager.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 23/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import UIKit
import CoreData

class WeekSearchStoreManager: NSObject {
	
    // MARK: - Variables
    
	let persistantContainer: NSPersistentContainer!
	
	init(container: NSPersistentContainer) {
		self.persistantContainer = container
		self.persistantContainer.viewContext.automaticallyMergesChangesFromParent = true
	}
	
	override convenience init() {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			fatalError("Can not get shared app delegate")
		}
		
		self.init(container: appDelegate.persistentContainer)
	}
	
	lazy var backgroundContext: NSManagedObjectContext = {
		return self.persistantContainer.newBackgroundContext()
	}()
	
	// MARK: - CRUD
	//Create Retrieve Update Data
	
    @discardableResult func insertReleaseDate(dateGreater: Double, dateSmaller: Double, data: Data) -> WeekSearchData? {
		guard let entity = NSEntityDescription.insertNewObject(forEntityName: "WeekSearchData", into: backgroundContext)
			as? WeekSearchData else { return nil }
		entity.dateGreater = dateGreater
		entity.dateSmaller = dateSmaller
		entity.data = data
		save()
        return entity
	}
	
	func fetch(dateGreater: Double, dateSmaller: Double) -> WeekSearchData? {
		let request: NSFetchRequest<WeekSearchData> = WeekSearchData.fetchRequest()
		request.fetchLimit = 1
		request.predicate = NSPredicate(format: "dateGreater = \(dateGreater)")
		request.predicate = NSPredicate(format: "dateSmaller = \(dateSmaller)")
		
		let results = try? backgroundContext.fetch(request)
		return results?.first
	}
	
	func fetchAll() -> [WeekSearchData] {
		let request: NSFetchRequest<WeekSearchData> = WeekSearchData.fetchRequest()
		let results = try? backgroundContext.fetch(request)
		return results ?? [WeekSearchData]()
	}
	
	func remove(objectID: NSManagedObjectID) {
		let obj = backgroundContext.object(with: objectID)
		backgroundContext.delete(obj)
	}
	
	func save() {
		if backgroundContext.hasChanges {
			do {
				try backgroundContext.save()
			} catch {
				print ("Save error \(error)")
			}
		}
	}
}
