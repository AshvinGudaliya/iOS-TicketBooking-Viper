//
//  UITextField+Theme.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

extension UITextField {
    
    enum StateType {
        case primary
        case error
    }
    
    func applyTheme(_ state: StateType) {
        switch state {
        case .primary:
            textColor = UIColor.appPrimary
            layer.cornerRadius = 12
            font = .latoFont(.Regular, size: 14)
            layer.cornerRadius = 12
            layer.borderWidth = 1
            layer.borderColor = textColor?.cgColor
            if let placeholder = placeholder {
                setPlaceholder(state: state, placeholder: placeholder)
            }
            
        case .error:
            layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func setPlaceholder(state: StateType, placeholder: String) {
        let placeholderColor = (textColor ?? UIColor.appPrimary).withAlphaComponent(0.5)
        attributedPlaceholder = NSAttributedString(string: placeholder.localized, attributes: [.foregroundColor: placeholderColor, .font: UIFont.latoFont(.Regular, size: 14)])
    }
}
