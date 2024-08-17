//
//  OnboardingProtocol.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

protocol OnboardingPresenterProtocol {
    var router: OnboardingRouterProtocol? { get set }
    func pushToLoginScreen()
    func pushToRegistrationScreen()
}

protocol OnboardingRouterProtocol {
    static func createModule() -> UINavigationController?
    func showRegistrationScreen()
    func showLoginScreen()
}
