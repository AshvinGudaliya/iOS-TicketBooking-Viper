//
//  SeatSelectionViewController.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class SeatSelectionViewController: UIViewController {
    
    @IBOutlet weak var generateRandomButton: UIButton!
    @IBOutlet weak var addCountTextField: BookingTextField!
    @IBOutlet weak var bookTicketButton: UIButton!
    @IBOutlet var indicatersColorViews: [UIView]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var bookedIndicatorLabel: UILabel!
    @IBOutlet weak var selectedIndicatorLabel: UILabel!
    @IBOutlet weak var availableIndicatorLabel: UILabel!
    
    let numberOfColumn: Int = 5
    
    var presenter: SeatSelectionPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "title_select_seat".localized
        configureUI()
        presenter?.fetchedSeatsAndBookings()
    }
    
    func configureUI() {
        
        addCountTextField.applyTheme(.primary)
        addCountTextField.delegate = self
        
        generateRandomButton.applyTheme(.primary)
        generateRandomButton.setTitle("btn_generate_random".localized, for: .normal)
        
        bookTicketButton.isEnabled = false
        bookTicketButton.applyTheme(.primary)
        bookTicketButton.setTitle("btn_book_ticket".localized, for: .normal)
        
        bookedIndicatorLabel.text = "lbl_booked_seat".localized
        bookedIndicatorLabel.applyTheme(.body)
        selectedIndicatorLabel.text = "lbl_selected_seat".localized
        selectedIndicatorLabel.applyTheme(.body)
        availableIndicatorLabel.text = "lbl_available_seat".localized
        availableIndicatorLabel.applyTheme(.body)
        
        for view in indicatersColorViews {
            view.layer.cornerRadius = 4
        }
    }
    
    @IBAction func generateRandomButtonAction(_ sender: UIButton) {
        guard let availableSeats = presenter?.remainingSeats() else {
            showError(message: "seats_are_currently_booked".localized)
            addCountTextField.text = nil
            return
        }
        guard availableSeats != 0 else {
            showError(message: "tickets_fully_booked_for_selected_date".localized)
            addCountTextField.text = nil
            return
        }
        let randomNumber = Int.random(in: 1...availableSeats)
        addCountTextField.text = randomNumber.description
        presenter?.removeAllSelectedSeats()
        presenter?.generateRandomSeats(count: randomNumber)
    }
    
    @IBAction func bookTicktButtonAction(_ sender: UIButton) {
        presenter?.bookSelectedSeats()
    }
}

extension SeatSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfSeats().count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatSelectionCollectionViewCell", for: indexPath) as? SeatSelectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        if presenter?.isSelected(at: indexPath.row) ?? false {
            cell.contentView.backgroundColor = .appBlue
        } else if presenter?.isBooked(at: indexPath.row) ?? false {
            cell.contentView.backgroundColor = .appGreen
        } else {
            cell.contentView.backgroundColor = .appGray
        }
        cell.contentView.layer.cornerRadius = 6
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - CGFloat(10 * (numberOfColumn + 1)) - 40) / CGFloat(numberOfColumn)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        presenter?.selectOrRemove(at: indexPath.row)
    }
}

extension SeatSelectionViewController: SeatSelectionViewProtocol {
    func dataFetchedOrChanged(hasSelectedSeat: Bool) {
        self.collectionView.reloadData()
        bookTicketButton.isEnabled = hasSelectedSeat
        bookTicketButton.applyTheme(.primary)
    }
    
    func showError(message: String) {
        showErrorAlert(message: message)
    }
    
    func showBookingCreatedSuccess(message: String) {
        showSuccessAlert(message: message) { [weak self] in
            self?.presenter?.pushToBookTicketScreen()
        }
    }
}

extension SeatSelectionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let randomNumber = numberFormatterFor(string: textField.text ?? "")?.intValue {
            presenter?.removeAllSelectedSeats()
            presenter?.generateRandomSeats(count: randomNumber)
        }
    }
    
    func numberFormatterFor(string: String?) -> NSNumber? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter.number(from: string ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Combine the current text with the replacement text
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Check if the updated text is a valid number
        let isValidNumber = numberFormatterFor(string: updatedText) != nil || updatedText.isEmpty
        
        guard let availableSeats = presenter?.remainingSeats() else { return false }
        
        // Check if the number is within the acceptable range
        if isValidNumber, let number = numberFormatterFor(string: updatedText)?.intValue {
            return number >= 0 && number <= availableSeats
        }
        
        return isValidNumber
    }
}
