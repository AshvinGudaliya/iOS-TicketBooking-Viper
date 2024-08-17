//
//  RegistrationRouter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class RegistrationRouter: RegistrationRouterProtocol {
    
    static func createModule() -> RegistrationViewController {
        let storyboard = StoryBoard.auth.getStoryBoard()
        let view = storyboard.instantiateViewController(ofType: RegistrationViewController.self)
        
        var presenter: RegistrationPresenterProtocol & RegistrationInteractorOutputProtocol = RegistrationPresenter()
        var interactor: RegistrationInteractorInputProtocol = RegistrationInteractor()
        let router: RegistrationRouterProtocol = RegistrationRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}

extension RegistrationRouter {
    func showDashboardScreen(user: Users) {
        SceneDelegate.configureViewController()
    }
}
