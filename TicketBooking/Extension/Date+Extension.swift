//
//  Date+Extension.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 16/08/24.
//

import UIKit

extension Date {
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    static var currentTimeStamp: String {
        return (Date().timeIntervalSince1970 * 1000).description
    }
}
