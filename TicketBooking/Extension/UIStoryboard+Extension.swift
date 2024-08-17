//
//  AppStoryBoard.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

enum StoryBoard: String {
    case auth = "Auth"
    case booking = "Booking"
    case dashboard = "Dashboard"
}

extension StoryBoard {
    func getStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func viewController<T: UIViewController>(ofType: T.Type) -> T {
        return self.getStoryBoard().instantiateViewController(ofType: ofType)
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        guard let controller = instantiateViewController(withIdentifier: identifier) as? T else {
            assertionFailure("instantiateNavigationController controller unwrapped failed")
            fatalError()
        }
        return controller
    }
}
