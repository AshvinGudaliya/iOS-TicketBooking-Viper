//
//  BookingCalendarProtocol.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

protocol BookingCalendarPresenterProtocol {
    
    var view: BookingCalendarViewProtocol? { get set }
    var interactor: BookingCalendarInteractorInputProtocol? { get set }
    var router: BookingCalendarRouterProtocol? { get set }
    func fetchBooking(date: Date)
    func pushToSeatSelectionScreen()
}

protocol BookingCalendarViewProtocol {
    func showError(message: String)
    func showBookingIsHouseFull(message: String)
}

protocol BookingCalendarRouterProtocol {
    static func createModule(_ navigation: UINavigationController?, user: Users) -> BookingCalendarViewController
    func showSeatSelectionScreen(user: Users, date: Date)
}

protocol BookingCalendarInteractorInputProtocol {
    var output: BookingCalendarInteractorOutputProtocol? { get set }
    func fetchBooking(date: Date)
    func fetchedSeats()
}

protocol BookingCalendarInteractorOutputProtocol {
    func fetchedBooking(booking: [Booking])
    func fetchedSeats(seats: [Seats])
    func showError(message: String)
}
