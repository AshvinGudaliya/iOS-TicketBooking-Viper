//
//  OnboardingViewController.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!

    var presenter: OnboardingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    func configureUI() {
        title = "title_onboarding".localized
        loginButton.applyTheme(.primary)
        loginButton.setTitle("title_login".localized, for: .normal)
        
        registrationButton.applyTheme(.secondary)
        registrationButton.setTitle("title_registration".localized, for: .normal)
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        presenter?.pushToLoginScreen()
    }
    
    @IBAction func registrationButtonAction(_ sender: UIButton) {
        presenter?.pushToRegistrationScreen()
    }
}
