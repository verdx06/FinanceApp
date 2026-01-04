//
//  ProfileCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import SwiftUI
import NavigationBackport

struct ProfileCoordinatorView: View
{
    @ObservedObject
    private var profileCoordinator: ProfileCoordinator

    init(profileCoordinator: ProfileCoordinator) {
        self.profileCoordinator = profileCoordinator
    }

    var body: some View {
        NBNavigationStack(path: self.$profileCoordinator.navigationPath) {
            self.profileCoordinator.build(screen: .profile)
                .nbNavigationDestination(for: ProfileCoordinator.Screen.self) { screen in
                    switch screen {
                    case .profile:
                        self.profileCoordinator.build(screen: .profile)
                    case .profileDetails:
                        self.profileCoordinator.build(screen: .profileDetails)
                    case .settings:
                        self.profileCoordinator.build(screen: .settings)
                    }
                }
        }
    }
}
