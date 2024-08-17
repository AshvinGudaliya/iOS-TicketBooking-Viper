//
//  BookingCalendarViewController.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class BookingCalendarViewController: UIViewController {
    
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView!
    @IBOutlet weak var weekDaysView: VAWeekDaysView!
    @IBOutlet weak var submitButton: UIButton!
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    var presenter: BookingCalendarPresenterProtocol?
    var calendarView: VACalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.fetchBooking(date: Date())
    }
    
    func configureUI() {
        title = "title_select_date".localized
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .single
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        view.addSubview(calendarView)
        
        submitButton.applyTheme(.primary)
        submitButton.setTitle("btn_submit".localized, for: .normal)
        
        let appereance = VAWeekDaysViewAppearance(symbolsType: .short, weekDayTextFont: UIFont.workSansFont(.SemiBold, size: 13), calendar: defaultCalendar)
        weekDaysView.appearance = appereance
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL yyyy"
        
        let monthAppereance = VAMonthHeaderViewAppearance(
            monthFont: UIFont.workSansFont(.SemiBold, size: 16),
            previousButtonImage: #imageLiteral(resourceName: "ic_cal_previous"),
            nextButtonImage: #imageLiteral(resourceName: "ic_cal_next"),
            dateFormatter: dateFormatter
        )
        monthHeaderView.delegate = self
        monthHeaderView.appearance = monthAppereance
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height * 0.6
            )
            calendarView.setup()
        }
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        presenter?.pushToSeatSelectionScreen()
    }
}

extension BookingCalendarViewController: BookingCalendarViewProtocol {
    func showBookingIsHouseFull(message: String) {
        submitButton.isEnabled = false
        submitButton.applyTheme(.primary)
        showErrorAlert(message: message)
    }
    
    func showError(message: String) {
        showErrorAlert(message: message)
    }
}

extension BookingCalendarViewController: VAMonthHeaderViewDelegate {
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
}

extension BookingCalendarViewController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .secondaryLabel
        case .unavailable:
            return .lightGray
        default:
            return .label
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return .red
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
}

extension BookingCalendarViewController: VACalendarViewDelegate {
    func selectedDate(_ date: Date) {
        submitButton.isEnabled = true
        submitButton.applyTheme(.primary)
        presenter?.fetchBooking(date: date)
    }
}


