//
//  Booking+CoreDataProperties.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//
//

import Foundation
import CoreData


extension Booking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Booking> {
        return NSFetchRequest<Booking>(entityName: "Booking")
    }

    @NSManaged public var bookingId: UUID
    @NSManaged public var seatId: String
    @NSManaged public var date: Date?
    @NSManaged public var userId: UUID
    @NSManaged public var toUser: Users?
    @NSManaged public var toSeat: Seats?

}

extension Booking : Identifiable {

}
