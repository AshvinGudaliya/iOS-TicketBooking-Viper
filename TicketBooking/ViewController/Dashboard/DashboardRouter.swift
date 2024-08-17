//
//  DashboardRouter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class DashboardRouter: DashboardRouterProtocol {
    weak var navigation: UINavigationController?
    
    static func createModule(user: Users) -> UINavigationController? {
        let storyboard = StoryBoard.dashboard.getStoryBoard()
        guard let navigation = storyboard.instantiateInitialViewController() as? UINavigationController else { return nil }
        guard let view = navigation.viewControllers.first as? DashboardViewController else { return nil }
        
        var presenter: DashboardPresenterProtocol & DashboardInteractorOutputProtocol = DashboardPresenter(user: user)
        var interactor: DashboardInteractorInputProtocol = DashboardInteractor()
        let router = DashboardRouter()
        router.navigation = navigation
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        return router.navigation
    }
}

extension DashboardRouter {
    func showBookTicketScreen(user: Users) {
        let registrationScreen = BookingCalendarRouter.createModule(navigation, user: user)
        self.navigation?.pushViewController(registrationScreen, animated: true)
    }
    
    func showOnboardingScreen() {
        SceneDelegate.configureViewController()
    }
}
