//
//  ContentView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 29.09.2025.
//

import SwiftUI

struct ContentView: View
{
    private let moduleFactory: ModuleFactory
    private let appCoordinator: AppCoordinator

    init() {
        let repositoryFactory = RepositoryFactory()
        let useCaseFactory = UseCaseFactory(repositoryFactory: repositoryFactory)
        self.moduleFactory = ModuleFactory(useCaseFactory: useCaseFactory)
        self.appCoordinator = AppCoordinator()
    }

    var body: some View {
        let authCoordinator = AuthCoordinator {
            Task { @MainActor in
                try await self.appCoordinator.routeToInitialFlow()
            }
        }

        AppCoordinatorView(
            appCoordinator: appCoordinator,
            moduleFactory: moduleFactory,
            authCoordinator: authCoordinator
        )
    }
}

#Preview {
    ContentView()
}
