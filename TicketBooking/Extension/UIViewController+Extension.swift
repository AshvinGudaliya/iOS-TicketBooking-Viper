//
//  UIViewController+Extension.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "", message: String = "", okAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert_okay".localized, style: .default) { _ in
            okAction?()
        })
        self.present(alert, animated: true)
    }
    
    func showErrorAlert(message: String) {
        showAlert(title: "alert_error".localized, message: message)
    }
    
    func showSuccessAlert(message: String, okAction: (() -> Void)? = nil) {
        showAlert(title: "alert_success".localized, message: message, okAction: okAction)
    }
}
