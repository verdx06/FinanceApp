//
//  RegistrationViewModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.10.2025.
//

import Foundation

@MainActor
final class RegistrationViewModel: ObservableObject
{
    private let router: Router
    private let registrationUseCase: RegistrationUseCaseProtocol
    private let validateEmailUseCase: ValidateEmailUseCaseProtocol
    private let validatePasswordUseCase: ValidatePasswordUseCaseProtocol
    private let validateNameUseCase: ValidateNameUseCaseProtocol

    @Published
    private(set) var state: ViewState

    @Published
    var isAlert: Bool = false

    init(
        router: Router,
        registrationUseCase: RegistrationUseCaseProtocol,
        validateEmailUseCase: ValidateEmailUseCaseProtocol,
        validatePasswordUseCase: ValidatePasswordUseCaseProtocol,
        validateNameUseCase: ValidateNameUseCaseProtocol
    ) {
        self.router = router
        self.registrationUseCase = registrationUseCase
        self.validateEmailUseCase = validateEmailUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
        self.validateNameUseCase = validateNameUseCase
        self.state = ViewState(registrationState: .initial)
    }

    func handle(_ event: Event) {
        switch event {
        case .loginButtonTapped:
            self.handleLogin()
        case .signUpButtomTapped:
            self.handleSignUp()
        case .emailChanged(let email):
            self.handleEmail(email: email)
        case .nameChanged(let name):
            self.handleName(name: name)
        case .passwordChanged(let password):
            self.handlePassword(password: password)
        }
    }
}

private extension RegistrationViewModel
{
    func handleLogin() {
        self.router.showLoginFlowHandler()
    }

    func handleSignUp() {
        if self.state.isContinueDisabled == false {
            Task { @MainActor in
                self.state.registrationState = .loading
                defer { self.state.registrationState = .initial }
                do {
                    try await self.registrationUseCase.execute(
                        UserRegistration(
                            email: self.state.email.content,
                            name: self.state.name.content,
                            phoneNumber: self.state.phoneNumber.content,
                            password: self.state.password.content
                        )
                    )
                    self.clearFields()
                    self.router.signUpHandler()
                } catch {
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                    self.isAlert = true
                    self.state.alertError = error.localizedDescription
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

    func handleName(name: String) {
        self.state.name.content = name

        do {
            try self.validateNameUseCase.execute(name)
            self.state.name.error = nil
        } catch {
            self.state.name.error = ValidateErrorHandler.message(error)
        }
    }

    func handlePassword(password: String) {
        self.state.password.content = password

        do {
            try self.validatePasswordUseCase.execute(password, additional: true)
            self.state.password.error = nil
        } catch {
            self.state.password.error = ValidateErrorHandler.message(error)
        }
    }

    func clearFields() {
        self.state.email.content = ""
        self.state.name.content = ""
        self.state.phoneNumber.content = ""
        self.state.password.content = ""
    }
}
