//
//  RegistrationProtocol.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

protocol RegistrationPresenterProtocol {
    
    var view: RegistrationViewProtocol? { get set }
    var interactor: RegistrationInteractorInputProtocol? { get set }
    var router: RegistrationRouterProtocol? { get set }
    func createUser(fullname: String, email: String, password: String)
    func pushToDashboardScreen(user: Users)
}

protocol RegistrationViewProtocol {
    func showError(message: String)
    func showSuccess(user: Users)
}

protocol RegistrationRouterProtocol {
    static func createModule() -> RegistrationViewController
    func showDashboardScreen(user: Users)
}

protocol RegistrationInteractorInputProtocol {
    var output: RegistrationInteractorOutputProtocol? { get set }
    func register(fullname: String, email: String, password: String)
}

protocol RegistrationInteractorOutputProtocol {
    func registerUserSuccess(user: Users)
    func registerFailed(message: String)
}
