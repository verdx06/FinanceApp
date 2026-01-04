//
//  LoginCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import SwiftUI
import NavigationBackport

struct LoginCoordinatorView: View
{
    @ObservedObject var coordinator: LoginCoordinator
    private let modularFactory: LoginCoordinatorFactory

    init(coordinator: LoginCoordinator, modularFactory: LoginCoordinatorFactory) {
        self.coordinator = coordinator
        self.modularFactory = modularFactory
    }

    var body: some View {
        NBNavigationStack(path: self.$coordinator.navigationPath) {
            destination(.login)
                .nbNavigationDestination(for: LoginCoordinator.Screens.self) {
                    self.destination($0)
                }
        }
    }
}

extension LoginCoordinatorView
{
    @ViewBuilder
    func destination(_ screen: LoginCoordinator.Screens) -> some View {
        switch screen {
        case .login:
            self.modularFactory.makeLoginView(coordinator: self.coordinator)
        }
    }
}
