//
//  LoginInteractor.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class LoginInteractor: LoginInteractorInputProtocol {

    var output: LoginInteractorOutputProtocol?
    
    func login(email: String, password: String) {
        let viewContext = CoreDataStack.shared.viewContext()
        if let user = Users.login(forEmail: email, password: password, in: viewContext) {
            user.marksAsLogin()
            output?.loginUserSuccess(user: user)
        } else {
            output?.loginFailed(message: "Login_Error".localized)
        }
    }
}
