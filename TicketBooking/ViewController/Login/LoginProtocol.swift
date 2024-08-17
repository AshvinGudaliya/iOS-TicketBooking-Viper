//
//  LoginProtocol.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

protocol LoginPresenterProtocol {
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    func login(email: String, password: String)
    func pushToDashboardScreen(user: Users)
}

protocol LoginViewProtocol {
    func showError(message: String)
    func showSuccess(user: Users)
}

protocol LoginRouterProtocol {
    static func createModule() -> LoginViewController
    func showDashboardScreen(user: Users)
}

protocol LoginInteractorInputProtocol {
    var output: LoginInteractorOutputProtocol? { get set }
    func login(email: String, password: String)
}

protocol LoginInteractorOutputProtocol {
    func loginUserSuccess(user: Users)
    func loginFailed(message: String)
}
