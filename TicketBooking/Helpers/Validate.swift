//
//  Validate.swift
//  TicketBooking
//
//  Created by Ashvin Gudaliya on 15/08/24.
//

import UIKit

struct Characters {
    struct Fullname {
        static let max = 25
        static let min = 3
    }
    
    struct Password {
        static let max = 20
        static let min = 8
    }
    
    struct Email {
        static let max = 100
    }
}

struct Validate {
    
    static func email(withText text: String?) throws {
        let text = try mandatoryText(text)
        
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        if !emailTest.evaluate(with: text) {
            let error: ValidationError = .invalidEmail
            throw error
        }
    }
    
    static func password(withText text: String) throws {
        if text.isEmpty { throw ValidationError.mandatoryField }
        
        let passwordTooShort = text.count < Characters.Password.min
        let missingNumber = text.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil
        let missingCapital = text.range(of: "[A-Z]", options: .regularExpression) == nil
        
        if passwordTooShort, missingNumber, missingCapital {
            throw ValidationError.invalidPasswordFull
        } else if passwordTooShort, missingCapital {
            throw ValidationError.invalidPasswordFullCapital
        } else if passwordTooShort, missingNumber {
            throw ValidationError.invalidPasswordFullNumber
        } else if missingCapital, missingNumber {
            throw ValidationError.invalidPasswordCapitalAndNumber
        } else if missingCapital {
            throw ValidationError.invalidPasswordCapital
        } else if missingNumber {
            throw ValidationError.invalidPasswordNumber
        } else if passwordTooShort {
            throw ValidationError.invalidPasswordMinCharacters
        }
    }
    
    static func mandatoryText(_ text: String?) throws -> String  {
        guard var text = text else {
            throw ValidationError.mandatoryField
        }
        
        //Trimming whitespaces from beginning and end
        text = text.trim()
        
        if text.isEmpty {
            throw ValidationError.mandatoryField
        }
        
        return text
    }
    
    static func fullnameText(withText text: String?) throws -> String  {
        let text = try mandatoryText(text)
        guard text.count > Characters.Fullname.min, text.count < Characters.Fullname.max else {
            throw ValidationError.invalidRangeFullname
        }

        let fullnameRegEx = "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
        let fullnameTest = NSPredicate(format:"SELF MATCHES[c] %@", fullnameRegEx)
        if !fullnameTest.evaluate(with: text) {
            throw ValidationError.invalidFullname
        }
        return text
    }
}

enum ValidationError: LocalizedError {
    case mandatoryField
    case invalidEmail
    case invalidFullname
    case invalidRangeFullname
    case invalidPasswordFull
    case invalidPasswordFullCapital
    case invalidPasswordFullNumber
    case invalidPasswordMinCharacters
    case invalidPasswordCapitalAndNumber
    case invalidPasswordCapital
    case invalidPasswordNumber
    
    var errorDescription: String? {
        switch self {
        case .mandatoryField: return "Sign_up_Error_mandatory_field".localized
        case .invalidEmail: return "Sign_up_Error_Valid_Email_field".localized
        case .invalidFullname: return "Sign_up_Error_Valid_Fullname_field".localized
        case .invalidRangeFullname: return "Sign_up_Error_invalid_range_Fullname_field".localized
        case .invalidPasswordFull: return "Sign_up_Error_password_Full".localized
        case .invalidPasswordFullCapital: return "Sign_up_Error_password_Full_Capital".localized
        case .invalidPasswordFullNumber: return "Sign_up_Error_password_Full_Number".localized
        case .invalidPasswordMinCharacters: return "Sign_up_Error_password_Min_Characters".localized
        case .invalidPasswordCapitalAndNumber: return "Sign_up_Error_password_Capital_Number".localized
        case .invalidPasswordCapital: return "Sign_up_Error_password_Capital".localized
        case .invalidPasswordNumber: return "Sign_up_Error_password_Number".localized
        }
    }
}









