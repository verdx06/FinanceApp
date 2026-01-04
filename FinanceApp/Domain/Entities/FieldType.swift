//
//  FieldType.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 15.11.2025.
//

import UIKit

enum FieldType: Equatable
{
    case email
    case password
    case name
    case phoneNumber
    case text

    var isRequired: Bool {
        switch self {
        case .text:
            false
        case .email, .password, .name, .phoneNumber:
            true
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .phoneNumber:
            return .phonePad
        case .password, .name, .text:
            return .default
        }
    }

    var isSecure: Bool {
        self == .password
    }

    var placeholder: String {
        switch self {
        case .email:
            return "Enter your email"
        case .password:
            return "Enter your password"
        case .name:
            return "Enter your name"
        case .phoneNumber:
            return "Enter phone number"
        case .text:
            return "Enter text"
        }
    }

    var header: String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .name:
            return "Name"
        case .phoneNumber:
            return "Phone"
        case .text:
            return "Text"
        }
    }
}
