//
//  SeatSelectionPresenter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

class SeatSelectionPresenter: SeatSelectionPresenterProtocol {

    var view: SeatSelectionViewProtocol?
    var interactor: SeatSelectionInteractorInputProtocol?
    var router: SeatSelectionRouterProtocol?
    private var user: Users
    private var date: Date
    
    private var seats: [Seats] = [Seats]()
    private var selectedSeats: [Seats] = [Seats]()
    private var bookedSeats: [Booking] = [Booking]()
    
    init(user: Users, date: Date) {
        self.user = user
        self.date = date
    }
    
    func fetchedSeatsAndBookings() {
        interactor?.fetchedSeats()
        interactor?.fetchBooking(date: date)
    }
    
    func bookSelectedSeats() {
        if selectedSeats.isEmpty {
            self.view?.showError(message: "select_seat_for_book_tickets".localized)
            return
        }
        interactor?.bookSelectedSeats(seats: selectedSeats, user: user, date: date)
    }
    
    func remainingSeats() -> Int {
        return seats.count - bookedSeats.count
    }
    
    func pushToBookTicketScreen() {
        router?.showBookTicketScreen()
    }
    
    func removeAllSelectedSeats() {
        self.selectedSeats.removeAll()
    }
    
    func generateRandomSeats(count: Int) {
        guard count != 0 else {
            self.view?.dataFetchedOrChanged(hasSelectedSeat: !selectedSeats.isEmpty)
            return
        }
        let random = Int.random(in: 0..<seats.count)
        if isSelected(at: random) {
            generateRandomSeats(count: count)
        } else if isBooked(at: random) {
            generateRandomSeats(count: count)
        } else {
            let seat = self.seats[random]
            selectedSeats.append(seat)
            generateRandomSeats(count: count - 1)
        }
    }
    
    func numberOfSeats() -> [Seats] {
        self.seats
    }
    
    func isSelected(at index: Int) -> Bool {
        let seat = self.seats[index]
        return selectedSeats.contains(seat)
    }
    
    func isBooked(at index: Int) -> Bool {
        let seat = self.seats[index]
        return bookedSeats.first(where: { $0.toSeat == seat}) != nil
    }
    
    func selectOrRemove(at index: Int) {
        let seat = self.seats[index]
        if isBooked(at: index) { return }
        if let index = selectedSeats.firstIndex(where: { $0.objectID == seat.objectID }) {
            selectedSeats.remove(at: index)
        } else {
            selectedSeats.append(seat)
        }
        self.view?.dataFetchedOrChanged(hasSelectedSeat: !selectedSeats.isEmpty)
    }
}

extension SeatSelectionPresenter: SeatSelectionInteractorOutputProtocol {
    func showBookingCreatedSuccess(message: String) {
        self.view?.showBookingCreatedSuccess(message: message)
    }
    
    func fetchedSeats(seats: [Seats]) {
        self.seats = seats
        self.view?.dataFetchedOrChanged(hasSelectedSeat: !selectedSeats.isEmpty)
    }
    
    func fetchedBooking(booking: [Booking]) {
        self.bookedSeats = booking
        self.selectedSeats.removeAll()
        self.view?.dataFetchedOrChanged(hasSelectedSeat: !selectedSeats.isEmpty)
    }
    
    func showError(message: String) {
        self.view?.showError(message: message)
    }
}
