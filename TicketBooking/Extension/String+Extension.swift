//
//  String+Extension.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}

extension String {
    public var localized: String {
        //Get the value from the Default set of Localization
        var result = Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        
        //Check if self and result are equal, if so we are missing the value for this key
        if result == self {
            debugPrint("Error missing localized String for key: \(self)")
        }
        
        return result
    }
}
