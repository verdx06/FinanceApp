//
//  AppCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import SwiftUI

struct AppCoordinatorView: View
{

    @ObservedObject var appCoordinator: AppCoordinator
    private let moduleFactory: ModuleFactory
    private var authCoordinator: AuthCoordinator

    init(appCoordinator: AppCoordinator, moduleFactory: ModuleFactory, authCoordinator: AuthCoordinator) {
        self.appCoordinator = appCoordinator
        self.moduleFactory = moduleFactory
        self.authCoordinator = authCoordinator
    }

    var body: some View {
        scene
            .animation(.default, value: self.appCoordinator.flow)
            .task {
                try? await self.appCoordinator.routeToInitialFlow()
            }
    }
}

extension AppCoordinatorView
{
    @ViewBuilder
    var scene: some View {
        switch self.appCoordinator.flow {
        case .loading:
            SplashLoadingView()
        case .auth:
            AuthCoordinatorView(
                authCoordinator: self.authCoordinator,
                modularFactory: self.moduleFactory
            )
        case .main:
            MainCoordinatorView(
                profileCoordinator: ProfileCoordinator(
                    logoutFlowHandler: self.appCoordinator.showAuthFlow,
                    modularFactory: self.moduleFactory
                ),
                coursesCoordinator: CoursesCoordinator(
                    modularFactory: self.moduleFactory
                ),
                homeCoordinator: HomeCoordinator(
                    modularFactory: self.moduleFactory
                ),
                mainCoordinator: .init(),
                transactionsCoordinator: TransactionsCoordinator(moduleFactory: self.moduleFactory)
            )
        }
    }
}
