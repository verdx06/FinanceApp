//
//  LoginCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import Foundation

@MainActor
final class LoginCoordinator: ObservableObject
{
    enum Screens
    {
        case login
    }

    @Published var navigationPath: [Screens] = []

    private let showRegistrationFlowHandler: () -> Void
    private let showMainFlowHandler: () -> Void

    init(showRegistrationFlowHandler: @escaping () -> Void, showMainFlowHandler: @escaping () -> Void) {
        self.showRegistrationFlowHandler = showRegistrationFlowHandler
        self.showMainFlowHandler = showMainFlowHandler
    }
}

extension LoginCoordinator
{
    func showRegistrationFlow() {
        self.showRegistrationFlowHandler()
    }
    func showMainFlow() {
        self.showMainFlowHandler()
    }
}
