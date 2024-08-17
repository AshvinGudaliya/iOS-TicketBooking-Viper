//
//  LoginViewController.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: BookingTextField!
    @IBOutlet weak var passwordTextField: BookingTextField!
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        title = "title_login".localized
        
        emailTextField.applyTheme(.primary)
        emailTextField.delegate = self
        
        passwordTextField.applyTheme(.primary)
        passwordTextField.configureAsPasswordField()
        passwordTextField.delegate = self
        
        loginButton.setTitle("title_login".localized, for: .normal)
        updateLoginButton()
    }
    
    func updateLoginButton() {
        loginButton.isEnabled = !((emailTextField.text ?? "").isEmpty || (passwordTextField.text ?? "").isEmpty)
        loginButton.applyTheme(.primary)
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard isValid() else { return }
        presenter?.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    func isValid() -> Bool {
        var hasError: Bool = false
        
        do {
            try Validate.email(withText: emailTextField.text ?? "")
        } catch let error {
            emailTextField.showValidationError(message: error.localizedDescription)
            hasError = true
        }
        
        do {
            try Validate.password(withText: passwordTextField.text ?? "")
        } catch let error {
            passwordTextField.showValidationError(message: error.localizedDescription)
            hasError = true
        }
        
        return !hasError
    }
}

extension LoginViewController: LoginViewProtocol {
    func showError(message: String) {
        showErrorAlert(message: message)
    }
    
    func showSuccess(user: Users) {
        presenter?.pushToDashboardScreen(user: user)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.applyTheme(.primary)
        (textField as? BookingTextField)?.hideValidationError()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButton()
    }
}

