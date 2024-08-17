//
//  OnboardingRouter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class OnboardingRouter: OnboardingRouterProtocol {
    weak var navigation: UINavigationController?
    
    static func createModule() -> UINavigationController? {
        let storyboard = StoryBoard.auth.getStoryBoard()
        guard let navigation = storyboard.instantiateInitialViewController() as? UINavigationController else { return nil }
        guard let view = navigation.viewControllers.first as? OnboardingViewController else { return nil }
    
        var presenter: OnboardingPresenterProtocol = OnboardingPresenter()
        let router = OnboardingRouter()
        view.presenter = presenter
        presenter.router = router
        router.navigation = navigation
        return navigation
    }
}

extension OnboardingRouter {
    func showRegistrationScreen() {
        let registrationScreen = RegistrationRouter.createModule()
        self.navigation?.pushViewController(registrationScreen, animated: true)
    }
    
    func showLoginScreen() {
        let loginScreen = LoginRouter.createModule()
        self.navigation?.pushViewController(loginScreen, animated: true)
    }
}
