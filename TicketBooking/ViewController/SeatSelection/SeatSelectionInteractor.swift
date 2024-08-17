//
//  SeatSelectionInteractor.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

class SeatSelectionInteractor: SeatSelectionInteractorInputProtocol {
    
    var output: SeatSelectionInteractorOutputProtocol?
    let viewContext = CoreDataStack.shared.viewContext()
    
    func fetchedSeats() {
        let seats = Seats.getAllSeats(in: viewContext)
        output?.fetchedSeats(seats: seats)
    }
    
    func fetchBooking(date: Date) {
        let bookings = Booking.fetchBooking(withDate: date, in: viewContext)
        output?.fetchedBooking(booking: bookings)
    }
    
    func bookSelectedSeats(seats: [Seats], user: Users, date: Date) {
        var bookedSeats: [Booking] = [Booking]()
        for seat in seats {
            if let booking = Booking.findOrCreateBooking(for: seat, user: user, date: date, in: viewContext) {
                bookedSeats.append(booking)
            } else {
                viewContext.rollback()
                output?.showError(message: "seat_wasnt_booked".localized)
                return
            }
        }
        CoreDataStack.shared.saveContext()
        output?.showBookingCreatedSuccess(message: "seat_booked_successfully".localized)
    }
}
