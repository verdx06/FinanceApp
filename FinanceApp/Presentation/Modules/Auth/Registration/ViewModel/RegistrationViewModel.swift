//
//  RegistrationViewModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.10.2025.
//

import Foundation

final class RegistrationViewModel: ObservableObject
{
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    func handle(_ event: Event) {
        switch event {
        case .loginButtonTapped:
            self.handleLogin()
        case .signUpButtomTapped:
            self.handleSignUp()
        }
    }
}

private extension RegistrationViewModel
{
    func handleLogin() {
        self.router.showLoginFlowHandler()
    }

    func handleSignUp() {
        self.router.signUpHandler()
    }
}
