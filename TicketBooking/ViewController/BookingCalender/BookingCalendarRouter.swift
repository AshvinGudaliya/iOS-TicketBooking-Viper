//
//  BookingCalendarRouter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class BookingCalendarRouter: BookingCalendarRouterProtocol {
    
    weak var navigation: UINavigationController?
    
    static func createModule(_ navigation: UINavigationController?, user: Users) -> BookingCalendarViewController {
        let storyboard = StoryBoard.booking.getStoryBoard()
        let view = storyboard.instantiateViewController(ofType: BookingCalendarViewController.self)
        
        var presenter: BookingCalendarPresenterProtocol & BookingCalendarInteractorOutputProtocol = BookingCalendarPresenter(user: user)
        var interactor: BookingCalendarInteractorInputProtocol = BookingCalendarInteractor()
        let router = BookingCalendarRouter()
        router.navigation = navigation
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}

extension BookingCalendarRouter {
    func showSeatSelectionScreen(user: Users, date: Date) {
        let registrationScreen = SeatSelectionRouter.createModule(navigation, user: user, date: date)
        self.navigation?.pushViewController(registrationScreen, animated: true)
    }
}
