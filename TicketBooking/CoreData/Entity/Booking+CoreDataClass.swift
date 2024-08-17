//
//  Booking+CoreDataClass.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//
//

import Foundation
import CoreData

@objc(Booking)
public class Booking: NSManagedObject, ManagedObjectCacheable {

    static func findOrCreateBooking(for seat: Seats, user: Users, date: Date, in context: NSManagedObjectContext) -> Booking? {
//        guard let seatId = seat.seatId else { return nil }
        let predicate = NSPredicate(format: "%K == NULL", #keyPath(Booking.date))
//        let predicate = NSPredicate(format: "%K == %@ AND %K == %@", #keyPath(Seats.seatId), seatId, #keyPath(Booking.date), date.startOfDay as CVarArg)
        let booking = findOrCreateManagedObject(in: context, matching: predicate) {
            $0.userId = user.userId
            $0.seatId = seat.seatId
            $0.bookingId = UUID()
        }
        
        booking.date = date.startOfDay
        seat.addToToBooking(booking)
        user.addToToBooking(booking)
        return booking
    }
    
    static func fetchBooking(withDate date: Date, in context: NSManagedObjectContext) -> [Booking] {
        return Booking.fetch(in: context) { request in
            request.predicate = NSPredicate(format: "%K == %@", #keyPath(Booking.date), date.startOfDay as CVarArg)
            request.returnsObjectsAsFaults = false
        }
    }
}
