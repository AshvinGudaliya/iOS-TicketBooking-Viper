//
//  Users+CoreDataProperties.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var userId: UUID
    @NSManaged public var accessToken: UUID?
    @NSManaged public var fullname: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var toBooking: NSSet?

}

// MARK: Generated accessors for toBooking
extension Users {

    @objc(addToBookingObject:)
    @NSManaged public func addToToBooking(_ value: Booking)

    @objc(removeToBookingObject:)
    @NSManaged public func removeFromToBooking(_ value: Booking)

    @objc(addToBooking:)
    @NSManaged public func addToToBooking(_ values: NSSet)

    @objc(removeToBooking:)
    @NSManaged public func removeFromToBooking(_ values: NSSet)

}

extension Users : Identifiable {

}
