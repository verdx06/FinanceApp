//
//  AuthCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import SwiftUI

struct AuthCoordinatorView: View
{
    @StateObject
    var authCoordinator: AuthCoordinator
    private let modularFactory: AuthCoordinatorFactory

    init(authCoordinator: AuthCoordinator, modularFactory: AuthCoordinatorFactory) {
        self._authCoordinator = StateObject(wrappedValue: authCoordinator)
        self.modularFactory = modularFactory
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                LoginCoordinatorView(
                    coordinator: LoginCoordinator(
                        showRegistrationFlowHandler: {
                            self.authCoordinator
                                .showRegisterView()
                        },
                        showMainFlowHandler: {
                            self.authCoordinator.showMainFlow()
                        }
                    ),
                    modularFactory: self.modularFactory
                )
                .frame(width: geometry.size.width)

                RegistrationCoordinatorView(
                    coordinator: RegistrationCoordinator(
                        showLoginFlowHandler: {
                            self.authCoordinator.showLoginView()
                        }
                    ),
                    moduleFactory: self.modularFactory
                )
                .frame(width: geometry.size.width)
            }
            .offset(x: self.authCoordinator.flow == .login ? 0 : -geometry.size.width)
            .animation(.easeInOut(duration: 0.3), value: self.authCoordinator.flow)
        }
    }
}
