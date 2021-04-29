//
//  CoreDataStack.swift
//  20210427-FritzGamboa-NYCSchools
//
//  Created by FGT MAC on 4/28/21.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Schools")
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistant store: \(error)")
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}
