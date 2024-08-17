//
//  UILabel+Theme.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

extension UILabel {
    
    enum StateType {
        case title
        case body
        case error
    }
    
    func applyTheme(_ state: StateType) {
        switch state {
        case .title:
            textColor = .label
            font = .latoFont(.Bold, size: 22)
            
        case .body:
            textColor = .label
            font = .latoFont(.Regular, size: 16)
            
        case .error:
            textColor = .red
            font = .latoFont(.Regular, size: 10)
        }
    }
}
