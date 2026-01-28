//
//  LoginViewModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject
{
    private let router: Router
    private let loginUseCase: LoginUseCaseProtocol
    private let validateEmailUseCase: ValidateEmailUseCaseProtocol
    private let validatePasswordUseCase: ValidatePasswordUseCaseProtocol

    @Published
    private(set) var state: ViewState

    @Published
    var isAlert: Bool = false

    init(
        router: Router,
        loginUseCase: LoginUseCaseProtocol,
        validateEmailUseCase: ValidateEmailUseCaseProtocol,
        validatePasswordUseCase: ValidatePasswordUseCaseProtocol
    ) {
        self.router = router
        self.state = ViewState(loginState: .initial)
        self.loginUseCase = loginUseCase
        self.validateEmailUseCase = validateEmailUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .signupTapped:
            self.handleShowSignUpView()
        case .emailChanged(email: let email):
            self.handleEmail(email: email)
        case .loginTapped:
            self.handleLogin()
        case .passwordChanged(password: let password):
            self.handlePassword(password: password)
        }
    }
}

private extension LoginViewModel
{
    func handleShowSignUpView() {
        self.router.showRegisterFlowHandler()
    }

    func handleLogin() {
        if self.state.isContinueDisabled == false {
            let credentials = AuthCredentials(email: self.state.email.content, password: self.state.password.content)
            Task { @MainActor in
                self.state.loginState = .loading
                defer { self.state.loginState = .initial }
                do {
                    try await self.loginUseCase.execute(credentials: credentials)
                    UserDefaults.standard.set(true, forKey: "login")
                    self.router.showMainFlowHandler()
                } catch {
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                    self.state.alertError = error.localizedDescription
                    self.isAlert = true
                }
            }
        }
    }

    func handleEmail(email: String) {
        self.state.email.content = email

        do {
            try self.validateEmailUseCase.execute(email)
            self.state.email.error = nil
        } catch {
            self.state.email.error = ValidateErrorHandler.message(error)
        }
    }

    func handlePassword(password: String) {
        self.state.password.content = password

        do {
            try self.validatePasswordUseCase.execute(password, additional: false)
            self.state.password.error = nil
        } catch {
            self.state.password.error = ValidateErrorHandler.message(error)
        }
    }
}
