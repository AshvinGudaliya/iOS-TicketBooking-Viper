//
//  SeatSelectionRouter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class SeatSelectionRouter: SeatSelectionRouterProtocol {
    
    weak var navigation: UINavigationController?
    
    static func createModule(_ navigation: UINavigationController?, user: Users, date: Date) -> SeatSelectionViewController {
        let storyboard = StoryBoard.booking.getStoryBoard()
        let view = storyboard.instantiateViewController(ofType: SeatSelectionViewController.self)
        
        var presenter: SeatSelectionPresenterProtocol & SeatSelectionInteractorOutputProtocol = SeatSelectionPresenter(user: user, date: date)
        var interactor: SeatSelectionInteractorInputProtocol = SeatSelectionInteractor()
        let router = SeatSelectionRouter()
        router.navigation = navigation
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}

extension SeatSelectionRouter {
    func showBookTicketScreen() {
        self.navigation?.popViewController(animated: true)
    }
}
