//
//  DashboardProtocol.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

protocol DashboardPresenterProtocol {
    
    var view: DashboardViewProtocol? { get set }
    var interactor: DashboardInteractorInputProtocol? { get set }
    var router: DashboardRouterProtocol? { get set }
    func fetchBooking()
    func greetingMessage() -> (gettingMessage: String, username: String)
    func pushToBookTicketScreen()
    func logoutAction()
}

protocol DashboardViewProtocol {
    func showError(message: String)
    func fetchedBooking(booking: [Booking]?, userBooked: [Booking]?)
}

protocol DashboardRouterProtocol {
    static func createModule(user: Users) -> UINavigationController?
    func showBookTicketScreen(user: Users)
    func showOnboardingScreen()
}

protocol DashboardInteractorInputProtocol {
    var output: DashboardInteractorOutputProtocol? { get set }
    func fetchBooking()
}

protocol DashboardInteractorOutputProtocol {
    func fetchedBooking(booking: [Booking]?)
    func showError(message: String)
}
