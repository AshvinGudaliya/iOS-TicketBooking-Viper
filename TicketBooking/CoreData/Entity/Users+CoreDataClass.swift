//
//  Users+CoreDataClass.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//
//

import Foundation
import CoreData

@objc(Users)
public class Users: NSManagedObject, ManagedObjectCacheable {
    
    static func findOrCreateUser(for userId: UUID, in context: NSManagedObjectContext) -> Users? {
        let predicate = NSPredicate(format: "%K == NULL", #keyPath(Users.userId))
        let user = findOrCreateManagedObject(in: context, matching: predicate) {
            $0.userId = userId
        }
        return user
    }
    
    static func findUser(forEmail email: String, in context: NSManagedObjectContext) -> Users? {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Users.email), email)
        let user = findOrFetchManagedObject(in: context, matching: predicate)
        return user
    }
    
    static func login(forEmail email: String, password: String, in context: NSManagedObjectContext) -> Users? {
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@", #keyPath(Users.email), email, #keyPath(Users.password), password)
        let user = findOrFetchManagedObject(in: context, matching: predicate)
        return user
    }
    
    static func currentUser(context: NSManagedObjectContext) -> Users? {
        let predicate = NSPredicate(format: "%K != NULL", #keyPath(Users.accessToken))
        let user = findOrFetchManagedObject(in: context, matching: predicate)
        return user
    }
    
    func marksAsLogin() {
        accessToken = UUID()
        CoreDataStack.shared.saveContext()
    }
    
    func logout() {
        accessToken = nil
        CoreDataStack.shared.saveContext()
    }
}
