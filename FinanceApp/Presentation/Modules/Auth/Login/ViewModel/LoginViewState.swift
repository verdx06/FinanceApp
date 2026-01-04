//
//  LoginViewState.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 14.11.2025.
//

import Foundation

extension LoginViewModel
{
    struct ViewState
    {
        var email = TextFieldState(.email)
        var password = TextFieldState(.password)
        var loginState: LoginState

        var isContinueDisabled: Bool {
            let isNotEmailValid = email.isInvalid
            let isNotPasswordValid = password.isInvalid
            return isNotEmailValid == true && isNotPasswordValid == true
        }
    }

    enum LoginState
    {
        case initial
        case loading
        case noConnecting
    }

    enum Event
    {
        case signupTapped
        case loginTapped
        case emailChanged(email: String)
        case passwordChanged(password: String)
    }
}
