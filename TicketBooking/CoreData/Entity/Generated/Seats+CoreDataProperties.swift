//
//  Seats+CoreDataProperties.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//
//

import Foundation
import CoreData


extension Seats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Seats> {
        return NSFetchRequest<Seats>(entityName: "Seats")
    }

    @NSManaged public var seatId: String
    @NSManaged public var uniqueId: String
    @NSManaged public var toBooking: NSSet?

}

// MARK: Generated accessors for toBooking
extension Seats {

    @objc(addToBookingObject:)
    @NSManaged public func addToToBooking(_ value: Booking)

    @objc(removeToBookingObject:)
    @NSManaged public func removeFromToBooking(_ value: Booking)

    @objc(addToBooking:)
    @NSManaged public func addToToBooking(_ values: NSSet)

    @objc(removeToBooking:)
    @NSManaged public func removeFromToBooking(_ values: NSSet)

}

extension Seats : Identifiable {

}
