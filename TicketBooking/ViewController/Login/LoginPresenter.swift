//
//  LoginPresenter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {
  
    var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func login(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
    
    func pushToDashboardScreen(user: Users) {
        router?.showDashboardScreen(user: user)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func loginUserSuccess(user: Users) {
        self.view?.showSuccess(user: user)
    }
    
    func loginFailed(message: String) {
        self.view?.showError(message: message)
    }
}
