//
//  RegistrationCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.10.2025.
//

import Foundation

final class RegistrationCoordinator: ObservableObject
{
    enum Screens
    {
        case registration
    }

    @Published var navigationPath: [Screens] = []
    private let showLoginFlowHandler: () -> Void

    init(showLoginFlowHandler: @escaping () -> Void) {
        self.showLoginFlowHandler = showLoginFlowHandler
    }
}

extension RegistrationCoordinator
{
    func showLoginFlow() {
        self.showLoginFlowHandler()
    }
}
