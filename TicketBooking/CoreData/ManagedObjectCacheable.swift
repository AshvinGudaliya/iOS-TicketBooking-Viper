//
//  ManagedObjectCacheable.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

public protocol ManagedObjectCacheable: NSFetchRequestResult {
    
}


extension ManagedObjectCacheable where Self: NSManagedObject {
    
    public static var entity: NSEntityDescription { return entity()  }
    public static var entityName: String { return entity.name!  }
    
    public static func findOrCreateManagedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate, configure: (Self) -> ()) -> Self {
        guard let object = findOrFetchManagedObject(in: context, matching: predicate) else {
            let newObject: Self = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! Self
            configure(newObject)
            return newObject
        }
        return object
    }
    
    public static func findOrFetchManagedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        guard let object = existingManagedObject(in: context, matching: predicate) else {
            let result = fetch(in: context) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 2
            }
            switch result.count {
            case 0: return nil
            case 1: return result.first
            default:
                fatalError("Returned more than 1 expected object")
            }
        }
        return object
    }

    public static func existingManagedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.isFault {
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        return nil
    }

    public static func fetch(in context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> () = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: Self.entityName)
        configurationBlock(request)
        return try! context.fetch(request)
    }
}
