//
//  DashboardPresenter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

class DashboardPresenter: DashboardPresenterProtocol {
    
    var view: DashboardViewProtocol?
    var interactor: DashboardInteractorInputProtocol?
    var router: DashboardRouterProtocol?
    var user: Users
    
    init(user: Users) {
        self.user = user
    }
    
    func greetingMessage() -> (gettingMessage: String, username: String) {
        var message = "good_evening".localized
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { message = "good_morning".localized }
        if hour < 18 { message = "good_afternoon".localized }
        return ("\(message)", "\("title_welcome".localized), \(user.fullname ?? "")")
    }
    
    func fetchBooking() {
        interactor?.fetchBooking()
    }

    func pushToBookTicketScreen() {
        router?.showBookTicketScreen(user: self.user)
    }
    
    func logoutAction() {
        self.user.logout()
        router?.showOnboardingScreen()
    }
}

extension DashboardPresenter: DashboardInteractorOutputProtocol {
    func fetchedBooking(booking: [Booking]?) {
        let userBooked = user.toBooking?.allObjects as? [Booking]
        self.view?.fetchedBooking(booking: booking, userBooked: userBooked)
    }
    
    func showError(message: String) {
        self.view?.showError(message: message)
    }
}
