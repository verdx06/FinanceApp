//
//  RegistrationCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.10.2025.
//

import SwiftUI
import NavigationBackport

struct RegistrationCoordinatorView: View
{

    @ObservedObject var coordinator: RegistrationCoordinator
    private let moduleFactory: AuthCoordinatorFactory

    init(coordinator: RegistrationCoordinator, moduleFactory: AuthCoordinatorFactory) {
        self.coordinator = coordinator
        self.moduleFactory = moduleFactory
    }

    var body: some View {
        NBNavigationStack(path: self.$coordinator.navigationPath) {
            destination(.registration)
                .nbNavigationDestination(for: RegistrationCoordinator.Screens.self) {
                    self.destination($0)
                }
        }
    }
}

extension RegistrationCoordinatorView
{
    @ViewBuilder
    func destination(_ screen: RegistrationCoordinator.Screens) -> some View {
        switch screen {
        case .registration:
            self.moduleFactory.makeRegistrationView(coordinator: self.coordinator)
        }
    }
}
