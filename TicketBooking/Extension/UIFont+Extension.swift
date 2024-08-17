//
//  UIFont+Extension.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

enum LatoFont: String {
    case Black
    case Bold
    case Light
    case Italic
    case Regular
    case Thin
    
    fileprivate func size(of size: CGFloat) -> UIFont {
        let font = UIFont(name: "Lato-\(self.rawValue)", size: size)!
        return font.scaledFont()
    }
}

extension UIFont {
    static func latoFont(_ font: LatoFont, size: CGFloat) -> UIFont {
        return font.size(of: size)
    }
    
    fileprivate func scaledFont(maximumPointSize: CGFloat = 30.0) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: self, maximumPointSize: maximumPointSize)
    }
}

enum WorkSans: String {
    case SemiBold
    
    fileprivate func size(of size: CGFloat) -> UIFont {
        let font = UIFont(name: "WorkSans-\(self.rawValue)", size: size)!
        return font.scaledFont()
    }
}

extension UIFont {
    static func workSansFont(_ font: WorkSans, size: CGFloat) -> UIFont {
        return font.size(of: size)
    }
}
