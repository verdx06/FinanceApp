//
//  ProfileCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import Foundation
import SwiftUI

final class ProfileCoordinator: ObservableObject
{
    enum Screen
    {
        case profile
        case profileDetails
        case settings
    }

    @Published
    var navigationPath: [Screen] = []

    private let logoutFlowHandler: () -> Void
    private let modularFactory: ProfileCoordinatorFactory

    init(logoutFlowHandler: @escaping () -> Void, modularFactory: ProfileCoordinatorFactory) {
        self.logoutFlowHandler = logoutFlowHandler
        self.modularFactory = modularFactory
    }
}

extension ProfileCoordinator
{
    @MainActor
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .profile:
            self.modularFactory.makeMainProfileView(coordinator: self)
        case .profileDetails:
            self.modularFactory.makeProfileDetailsView()
        case .settings:
            self.modularFactory.makeProfileSettingsView()
        }
    }

    func logoutHandler() {
        self.logoutFlowHandler()
    }

    func settingsHandler() {
        self.navigationPath.append(.settings)
    }

    func profileDetailsHandler() {
        self.navigationPath.append(.profileDetails)
    }
}
