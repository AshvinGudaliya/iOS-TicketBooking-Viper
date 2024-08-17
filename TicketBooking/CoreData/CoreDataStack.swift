//
//  CoreDataStack.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private init() { }

    let appContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TicketBooking")
        return container
    }()
    
    public func viewContext() -> NSManagedObjectContext {
        return appContainer.viewContext
    }

    public func createPersistentContainer(completion: @escaping (NSPersistentContainer) -> ()) {
        appContainer.loadPersistentStores { [weak self] _, error in
            if error == nil {
                guard let _self = self else { return }
                _self.appContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                _self.appContainer.viewContext.undoManager = nil
                _self.appContainer.viewContext.automaticallyMergesChangesFromParent = true
                let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
                completion(_self.appContainer)
            } else {
                //todo: handle
                fatalError("Unresolved error \(String(describing: error))")
            }
        }
    }
    
    public func saveOrRollback() -> Bool {
        do {
            try appContainer.viewContext.save()
            return true
        } catch let error {
            appContainer.viewContext.rollback()
            debugPrint("----->>  Rollback Error: \(error)")
            //fatalError("Rollback Error: \(error)")
            return false
        }
    }
    
    func saveContext() {
        _ = saveOrRollback()
    }
}
