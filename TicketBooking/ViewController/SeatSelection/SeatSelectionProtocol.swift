//
//  SeatSelectionProtocol.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

protocol SeatSelectionPresenterProtocol {
    
    var view: SeatSelectionViewProtocol? { get set }
    var interactor: SeatSelectionInteractorInputProtocol? { get set }
    var router: SeatSelectionRouterProtocol? { get set }

    func fetchedSeatsAndBookings()
    func pushToBookTicketScreen()
    func bookSelectedSeats()
    func removeAllSelectedSeats()
    func numberOfSeats() -> [Seats]
    func isSelected(at index: Int) -> Bool
    func isBooked(at index: Int) -> Bool
    func generateRandomSeats(count: Int)
    func remainingSeats() -> Int
    func selectOrRemove(at index: Int)
}

protocol SeatSelectionViewProtocol {
    func showError(message: String)
    func dataFetchedOrChanged(hasSelectedSeat: Bool)
    func showBookingCreatedSuccess(message: String)
}

protocol SeatSelectionRouterProtocol {
    static func createModule(_ navigation: UINavigationController?, user: Users, date: Date) -> SeatSelectionViewController
    func showBookTicketScreen()
}

protocol SeatSelectionInteractorInputProtocol {
    var output: SeatSelectionInteractorOutputProtocol? { get set }
    func fetchBooking(date: Date)
    func fetchedSeats()
    func bookSelectedSeats(seats: [Seats], user: Users, date: Date)
}

protocol SeatSelectionInteractorOutputProtocol {
    func fetchedBooking(booking: [Booking])
    func fetchedSeats(seats: [Seats])
    func showError(message: String)
    func showBookingCreatedSuccess(message: String)
}
