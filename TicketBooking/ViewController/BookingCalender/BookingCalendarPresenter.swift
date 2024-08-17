//
//  BookingCalendarPresenter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

class BookingCalendarPresenter: BookingCalendarPresenterProtocol {
    
    var view: BookingCalendarViewProtocol?
    var interactor: BookingCalendarInteractorInputProtocol?
    var router: BookingCalendarRouterProtocol?
    var user: Users
    var seats: [Seats] = [Seats]()
    var bookingOnDate: [Booking] = [Booking]()
    var selectedDate: Date?
    
    init(user: Users) {
        self.user = user
    }
    
    func checkBookingIsHouseFull() -> Bool {
        guard let date = selectedDate?.startOfDay else {
            self.view?.showError(message: "select_date_for_book_tickets".localized)
            return false
        }
        
        let bookedSets = seats.filter { seat in
            guard let booking = seat.toBooking as? Set<Booking> else { return true }
            let contains = booking.contains(where: { booking in
                booking.date == date
            })
            return contains
        }
        return seats.count == bookedSets.count
    }
    
    func fetchBooking(date: Date) {
        if seats.isEmpty {
            interactor?.fetchedSeats()
        }
        self.selectedDate = date
        interactor?.fetchBooking(date: date)
    }

    func pushToSeatSelectionScreen() {
        guard let date = selectedDate else {
            self.view?.showError(message: "select_date_for_book_tickets".localized)
            return
        }
        router?.showSeatSelectionScreen(user: self.user, date: date)
    }
}

extension BookingCalendarPresenter: BookingCalendarInteractorOutputProtocol {
    func fetchedSeats(seats: [Seats]) {
        self.seats = seats
    }
    
    func fetchedBooking(booking: [Booking]) {
        self.bookingOnDate = booking
        if checkBookingIsHouseFull() {
            self.view?.showBookingIsHouseFull(message: "tickets_fully_booked_for_selected_date".localized)
            return
        }
    }
    
    func showError(message: String) {
        self.view?.showError(message: message)
    }
}
