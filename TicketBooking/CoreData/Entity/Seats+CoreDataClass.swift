//
//  Seats+CoreDataClass.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//
//

import Foundation
import CoreData

@objc(Seats)
public class Seats: NSManagedObject, ManagedObjectCacheable {

    struct JsonSeat: Codable {
        let uniqueId: String
        let seatId: String
    }
    
    static func getAllSeats(in context: NSManagedObjectContext) -> [Seats] {
        return Seats.fetch(in: context) { request in
            request.returnsObjectsAsFaults = false
        }
    }
    
    static func configureDefault() {
        guard let path = Bundle.main.url(forResource: "SeatConfiguration", withExtension: "json") else {
            fatalError("File not found on selected target")
        }
        
        do {
            let seatData = try Data(contentsOf: path, options: .mappedIfSafe)
            let seats = try JSONDecoder().decode([JsonSeat].self, from: seatData)
            let viewContext = CoreDataStack.shared.viewContext()
            for seat in seats {
                findOrCreateSeat(for: seat, in: viewContext)
            }
            try viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @discardableResult
    static func findOrCreateSeat(for jSeat: JsonSeat, in context: NSManagedObjectContext) -> Seats? {
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Seats.uniqueId), jSeat.uniqueId)
        let seat = findOrCreateManagedObject(in: context, matching: predicate) {
            $0.uniqueId = jSeat.uniqueId
        }
        seat.seatId = jSeat.seatId
        return seat
    }
}
