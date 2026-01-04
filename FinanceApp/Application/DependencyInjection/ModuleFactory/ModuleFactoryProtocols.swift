//
//  ModuleFactoryProtocols.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 06.10.2025.
//

import Foundation

@MainActor
protocol LoginViewFactory: AnyObject
{
    func makeLoginView(
        coordinator: LoginCoordinator
    ) -> LoginViewContainer
}

@MainActor
protocol RegistrationViewFactory: AnyObject
{
    func makeRegistrationView(
        coordinator: RegistrationCoordinator
    ) -> RegistrationViewContainer
}

@MainActor
protocol MainProfileViewFactory: AnyObject
{
    func makeMainProfileView(coordinator: ProfileCoordinator) -> MainProfileViewContainer
}

@MainActor
protocol ProfileDetailsViewFactory: AnyObject
{
    func makeProfileDetailsView() -> ProfileDetailsContainer
}

@MainActor
protocol ProfileSettingsViewFactory: AnyObject
{
    func makeProfileSettingsView() -> ProfileSettingsContainer
}

@MainActor
protocol CoursesViewFactory: AnyObject
{
    func makeCoursesView() -> CoursesViewContainer
}

protocol HomeViewFactory: AnyObject
{
    func makeHomeView(coordinator: HomeCoordinator) -> HomeViewContainer
}
