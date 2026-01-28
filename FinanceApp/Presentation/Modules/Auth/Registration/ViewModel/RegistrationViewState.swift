//
//  RegistrationViewState.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 15.11.2025.
//

import Foundation

extension RegistrationViewModel
{
    struct ViewState
    {
        var email = TextFieldState(.email)
        var name = TextFieldState(.name)
        var phoneNumber = TextFieldState(.phoneNumber)
        var password = TextFieldState(.password)
        var alertError: String = ""
        var registrationState: RegistrationState

        var isContinueDisabled: Bool {
            let isNotEmailValid = email.isInvalid
            let isNotPasswordValid = password.isInvalid
            let isNotNameValid = name.isInvalid
            return isNotEmailValid == true && isNotPasswordValid == true && isNotNameValid == true
        }
    }

    enum RegistrationState
    {
        case initial
        case loading
        case noConnecting
    }

    enum Event
    {
        case signUpButtomTapped
        case loginButtonTapped
        case emailChanged(email: String)
        case nameChanged(name: String)
        case passwordChanged(password: String)
    }
}
