//
//  RegistrationPresenter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class RegistrationPresenter: RegistrationPresenterProtocol {
  
    var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorInputProtocol?
    var router: RegistrationRouterProtocol?
    
    func createUser(fullname: String, email: String, password: String) {
        interactor?.register(fullname: fullname, email: email, password: password)
    }
    
    func pushToDashboardScreen(user: Users) {
        router?.showDashboardScreen(user: user)
    }
}

extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    func registerUserSuccess(user: Users) {
        self.view?.showSuccess(user: user)
    }
    
    func registerFailed(message: String) {
        self.view?.showError(message: message)
    }
}
