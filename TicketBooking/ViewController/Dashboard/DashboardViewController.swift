//
//  DashboardViewController.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var gettingMessageLabel: UILabel!
    @IBOutlet weak var wellcomeLabel: UILabel!
    @IBOutlet weak var totalBookingLabel: UILabel!
    @IBOutlet weak var totalUserBookingLabel: UILabel!
    @IBOutlet weak var bookMyTicketButton: UIButton!

    var presenter: DashboardPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.populateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchBooking()
    }
    
    func configureUI() {
        title = "title_dashboard".localized
        wellcomeLabel.applyTheme(.title)
        gettingMessageLabel.applyTheme(.title)
        totalBookingLabel.applyTheme(.body)
        totalUserBookingLabel.applyTheme(.body)
        totalBookingLabel.applyTheme(.body)
        
        bookMyTicketButton.applyTheme(.primary)
        bookMyTicketButton.setTitle("btn_book_my_ticket".localized, for: .normal)
        
        let logout = UIBarButtonItem(title: "btn_logout".localized, style: .plain, target: self, action: #selector(logoutButtonAction(_:)))
        navigationItem.rightBarButtonItem = logout
    }
    
    func populateData() {
        let greetingMessage = presenter?.greetingMessage()
        gettingMessageLabel.text = greetingMessage?.gettingMessage
        wellcomeLabel.text = greetingMessage?.username
    }
    
    @IBAction func bookMyTicketButtonAction(_ sender: UIButton) {
        presenter?.pushToBookTicketScreen()
    }
    
    @objc func logoutButtonAction(_ sender: UIBarButtonItem) {
        presenter?.logoutAction()
    }
}

extension DashboardViewController: DashboardViewProtocol {
    func fetchedBooking(booking: [Booking]?, userBooked: [Booking]?) {
        totalBookingLabel.text = "total_booking".localized + "\(booking?.count ?? 0)"
        totalUserBookingLabel.text = "total_user_booked".localized + "\(userBooked?.count ?? 0)"
    }
    
    func showError(message: String) {
        showErrorAlert(message: message)
    }
}
