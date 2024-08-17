//
//  UIButton+Theme.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

extension UIButton {
    
    enum StateType {
        case primary
        case secondary
    }
    
    func applyTheme(_ state: StateType) {
        switch state {
        case .primary:
            setTitleColor(.white, for: .normal)
            backgroundColor = isEnabled ? UIColor.appPrimary : UIColor.gray.withAlphaComponent(0.5)
            layer.cornerRadius = 12
            titleLabel?.font = .latoFont(.Regular, size: 16)
            
        case .secondary:
            let color = isEnabled ? UIColor.appPrimary : UIColor.gray.withAlphaComponent(0.5)
            setTitleColor(color, for: .normal)
            layer.cornerRadius = 12
            layer.borderWidth = 1
            layer.borderColor = color.cgColor
            titleLabel?.font = .latoFont(.Regular, size: 16)
        }
    }
}
