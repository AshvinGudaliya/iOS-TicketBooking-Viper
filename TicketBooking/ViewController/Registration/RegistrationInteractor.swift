//
//  RegistrationInteractor.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class RegistrationInteractor: RegistrationInteractorInputProtocol {
    var output: RegistrationInteractorOutputProtocol?
    
    func register(fullname: String, email: String, password: String) {
        let viewContext = CoreDataStack.shared.viewContext()
        if Users.findUser(forEmail: email, in: viewContext) != nil {
            output?.registerFailed(message: "Sign_up_Error_email_already_register".localized)
            return
        }
        
        let uniqueUserId = UUID()
        guard let user = Users.findOrCreateUser(for: uniqueUserId, in: viewContext) else {
            output?.registerFailed(message: "Error_local_generic".localized)
            return
        }
        user.email = email
        user.password = password
        user.fullname = fullname
        user.userId = uniqueUserId
        user.accessToken = UUID()
        do {
            try viewContext.save()
            output?.registerUserSuccess(user: user)
        } catch {
            viewContext.rollback()
            output?.registerFailed(message: error.localizedDescription)
        }
    }
}
