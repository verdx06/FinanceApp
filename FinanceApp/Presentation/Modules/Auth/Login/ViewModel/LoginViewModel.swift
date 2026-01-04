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
    private let validateUseCase: ValidateAuthUseCaseProtocol

    @Published
    private(set) var state: ViewState

    init(router: Router, loginUseCase: LoginUseCaseProtocol, validateUseCase: ValidateAuthUseCaseProtocol) {
        self.router = router
        self.state = ViewState(loginState: .initial)
        self.loginUseCase = loginUseCase
        self.validateUseCase = validateUseCase
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
            Task {
                do {
                    self.state.loginState = .loading
                    try await self.loginUseCase.execute(credentials: credentials)
                    UserDefaults.standard.set(true, forKey: "login")
                    self.router.showMainFlowHandler()
                } catch {
                    self.state.loginState = .initial
                    print(error.localizedDescription)
                }
            }
        }
    }

    func handleEmail(email: String) {
        self.state.email.content = email

        do {
            try self.validateUseCase.executeEmail(email)
            self.state.email.error = nil
        } catch {
            self.state.email.error = ValidateErrorHandler.message(error)
        }
    }

    func handlePassword(password: String) {
        self.state.password.content = password

        do {
            try self.validateUseCase.executePassword(password)
            self.state.password.error = nil
        } catch {
            self.state.password.error = ValidateErrorHandler.message(error)
        }
    }
}
