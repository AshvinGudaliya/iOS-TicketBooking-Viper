//
//  DashboardInteractor.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

class DashboardInteractor: DashboardInteractorInputProtocol {

    var output: DashboardInteractorOutputProtocol?
    
    func fetchBooking() {
        let viewContext = CoreDataStack.shared.viewContext()
        let userBooking = Booking.fetch(in: viewContext) { request in
            request.returnsObjectsAsFaults = false
        }
        
        output?.fetchedBooking(booking: userBooking)
    }
}
