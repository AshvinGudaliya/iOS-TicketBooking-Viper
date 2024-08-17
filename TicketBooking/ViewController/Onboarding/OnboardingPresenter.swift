//
//  OnboardingPresenter.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class OnboardingPresenter: OnboardingPresenterProtocol {
    var router: OnboardingRouterProtocol?
    
    func pushToLoginScreen() {
        router?.showLoginScreen()
    }
    
    func pushToRegistrationScreen() {
        router?.showRegistrationScreen()
    }
}
