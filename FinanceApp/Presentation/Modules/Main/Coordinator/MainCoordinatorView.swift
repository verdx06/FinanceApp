//
//  MainCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import Foundation
import SwiftUI

struct MainCoordinatorView: View
{
    private let profileCoordinator: ProfileCoordinator
    private let coursesCoordinator: CoursesCoordinator
    private let homeCoordinator: HomeCoordinator

    @ObservedObject
    private var mainCoordinator: MainCoordinator

    @State
    private var activeTab: AppTab = .home

    init(
        profileCoordinator: ProfileCoordinator,
        coursesCoordinator: CoursesCoordinator,
        homeCoordinator: HomeCoordinator,
        mainCoordinator: MainCoordinator
    ) {
        self.profileCoordinator = profileCoordinator
        self.coursesCoordinator = coursesCoordinator
        self.homeCoordinator = homeCoordinator
        self.mainCoordinator = mainCoordinator
    }

    var body: some View {
        CustomTabView(selection: $activeTab) { tab, _ in
            switch tab {
            case .home:
                HomeCoordinatorView(coordinator: self.homeCoordinator)
                    .tag(MainCoordinator.Tab.home)
            case .profile:
                ProfileCoordinatorView(profileCoordinator: self.profileCoordinator)
                    .tag(MainCoordinator.Tab.profile)
            case .analysis:
                Text("Lol")
            case .transactions:
                Text("Transactions")
            case .cases:
                CoursesCoordinatorView(coursesCoordinator: self.coursesCoordinator)
                    .tag(MainCoordinator.Tab.cases)
            }
        }
    }
}

extension MainCoordinatorView
{
    enum AppTab: String, CaseIterable
    {
        case home = "Home"
        case analysis = "Analysis"
        case transactions = "Transactions"
        case cases = "Courses"
        case profile = "ProfileTab"
    }
}

#Preview {
    MainCoordinatorView(
        profileCoordinator: ProfileCoordinator(
            logoutFlowHandler: {
            },
            modularFactory: ModuleFactory(
                useCaseFactory: UseCaseFactory(
                    repositoryFactory: RepositoryFactory()
                )
            )
        ),
        coursesCoordinator: CoursesCoordinator(
            modularFactory: ModuleFactory(
                useCaseFactory: UseCaseFactory(
                    repositoryFactory: RepositoryFactory()
                )
            )
        ),
        homeCoordinator: HomeCoordinator(
            modularFactory: ModuleFactory(useCaseFactory: UseCaseFactory(repositoryFactory: RepositoryFactory()))
        ),
        mainCoordinator: MainCoordinator()
    )
}
