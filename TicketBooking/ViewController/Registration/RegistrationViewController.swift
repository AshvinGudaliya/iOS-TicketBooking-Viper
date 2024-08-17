//
//  RegistrationViewController.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class RegistrationViewController: UIViewController {
   
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var fullnameTextField: BookingTextField!
    @IBOutlet weak var emailTextField: BookingTextField!
    @IBOutlet weak var passwordTextField: BookingTextField!

    var presenter: RegistrationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        title = "title_registration".localized
        fullnameTextField.applyTheme(.primary)
        fullnameTextField.delegate = self
        
        emailTextField.applyTheme(.primary)
        emailTextField.delegate = self
        
        passwordTextField.applyTheme(.primary)
        passwordTextField.configureAsPasswordField()
        passwordTextField.delegate = self
        
        registrationButton.setTitle("title_registration".localized, for: .normal)
        updateRegistrationButton()
    }
    
    func updateRegistrationButton() {
        registrationButton.isEnabled = !((fullnameTextField.text ?? "").isEmpty || (emailTextField.text ?? "").isEmpty || (passwordTextField.text ?? "").isEmpty)
        registrationButton.applyTheme(.primary)
    }
    
    @IBAction func registrationButtonAction(_ sender: UIButton) {
        guard isValid() else { return }
        presenter?.createUser(fullname: fullnameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    func isValid() -> Bool {
        var hasError: Bool = false
        do {
            fullnameTextField.text = try Validate.fullnameText(withText: fullnameTextField.text ?? "")
        } catch let error {
            fullnameTextField.showValidationError(message: error.localizedDescription)
            hasError = true
        }
        
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

extension RegistrationViewController: RegistrationViewProtocol {
    func showError(message: String) {
        showErrorAlert(message: message)
    }
    
    func showSuccess(user: Users) {
        presenter?.pushToDashboardScreen(user: user)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullnameTextField {
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField {
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
        updateRegistrationButton()
    }
}
