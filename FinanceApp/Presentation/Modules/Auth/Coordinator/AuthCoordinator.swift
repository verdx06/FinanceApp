//
//  AuthCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import Foundation

@MainActor
final class AuthCoordinator: ObservableObject
{
    enum Screens
    {
        case login
        case registration
//        case forgotPassword
    }

    @Published var flow: Screens = .login

    private let showMainFlowHandler: () -> Void

    init(showMainFlowHandler: @escaping () -> Void) {
        self.showMainFlowHandler = showMainFlowHandler
    }
}

extension AuthCoordinator
{
    func showLoginView() {
        self.flow = .login
    }

    func showRegisterView() {
        self.flow = .registration
    }

    func showMainFlow() {
        self.showMainFlowHandler()
    }
}
