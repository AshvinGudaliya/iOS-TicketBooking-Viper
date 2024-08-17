//
//  BookingCalendarInteractor.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

class BookingCalendarInteractor: BookingCalendarInteractorInputProtocol {
    
    var output: BookingCalendarInteractorOutputProtocol?
    private let viewContext = CoreDataStack.shared.viewContext()
    
    func fetchedSeats() {
        let seats = Seats.getAllSeats(in: viewContext)
        output?.fetchedSeats(seats: seats)
    }
    
    func fetchBooking(date: Date) {
        let bookings = Booking.fetchBooking(withDate: date, in: viewContext)
        output?.fetchedBooking(booking: bookings)
    }
}
