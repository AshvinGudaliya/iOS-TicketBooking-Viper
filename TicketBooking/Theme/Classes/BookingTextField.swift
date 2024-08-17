//
//  BookingTextField.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

class BookingTextField: UITextField, UITextFieldDelegate {
    
    private var paddingInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    private var imagePadding: CGFloat = 10
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.applyTheme(.error)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // Provides left padding for image
    internal override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += imagePadding
        paddingInsets.left = textRect.origin.x + textRect.width  + imagePadding
        return textRect
    }
    
    // Provides right padding for image
    internal override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= imagePadding
        paddingInsets.right = textRect.width + (imagePadding * 2)
        return textRect
    }
    
    internal override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingInsets)
    }
    
    internal override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingInsets)
    }
    
    internal override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingInsets)
    }
    
    private lazy var passwordImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: self.frame.height/2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.frame.height/2).isActive = true
        imageView.tintColor = UIColor.appPrimary
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupToolbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupToolbar()
    }
    
    func setupToolbar() {
        //Create a toolbar
        let bar = UIToolbar()
        
        //Create a done button with an action to trigger our function to dismiss the keyboard
        let doneBtn = UIBarButtonItem(title: "btn_done".localized, style: .plain, target: self, action: #selector(dismissMyKeyboard))
        
        //Create a felxible space item so that we can add it around in toolbar to position our done button
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //Add the created button items in the toobar
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        
        //Add the toolbar to our textfield
        inputAccessoryView = bar
    }
    
    @objc func dismissMyKeyboard(){
        resignFirstResponder()
    }
    
    func configureAsPasswordField() {
        rightViewMode = UITextField.ViewMode.always
        updateImageForPasswordField()
        rightView = passwordImageView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showHiddenPasswordAction(_:)))
        tap.numberOfTapsRequired = 1
        passwordImageView.addGestureRecognizer(tap)
    }
    
    private func updateImageForPasswordField() {
        passwordImageView.image = UIImage(systemName: isSecureTextEntry ? "eye.fill" : "eye.slash.fill")
    }
    
    @objc func showHiddenPasswordAction(_ sender: UIButton) {
        let tempText = self.text
        isSecureTextEntry = !isSecureTextEntry
        self.text = tempText
        self.updateImageForPasswordField()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // Make sure that errorLabel is added once to the superview, not to the text field itself
        if let superview = superview, errorLabel.superview == nil {
            superview.addSubview(errorLabel)
            configureErrorLabelConstraints()
        }
    }
    
    private func configureErrorLabelConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 2),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func showValidationError(message: String) {
        errorLabel.textColor = .red
        layer.borderColor = UIColor.red.cgColor
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideValidationError() {
        errorLabel.isHidden = true
    }
}

enum TextField {
    case email(String)
    case password(String)
    case fullname(String)
    
    func validate() throws {
        switch self {
        case .email(let email):
            try Validate.email(withText: email)
        case .password(let password):
            try Validate.password(withText: password)
        case .fullname(let phoneNumber):
            let _ = try Validate.fullnameText(withText: phoneNumber)
        }
    }
}
