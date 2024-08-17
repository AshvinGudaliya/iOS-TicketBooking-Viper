//
//  LoginRouter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    static func createModule() -> LoginViewController {
        let storyboard = StoryBoard.auth.getStoryBoard()
        let view = storyboard.instantiateViewController(ofType: LoginViewController.self)
        
        var presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        var interactor: LoginInteractorInputProtocol = LoginInteractor()
        let router: LoginRouterProtocol = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter
        
        return view
    }
}

extension LoginRouter {
    func showDashboardScreen(user: Users) {
        SceneDelegate.configureViewController()
    }
}
