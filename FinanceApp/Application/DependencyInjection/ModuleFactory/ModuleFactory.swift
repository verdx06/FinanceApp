//
//  ModuleFactory.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 06.10.2025.
//

import Foundation

final class ModuleFactory
{
    private let useCaseFactory: UseCaseFactory

    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
}

extension ModuleFactory: LoginViewFactory
{
    @MainActor
    func makeLoginView(coordinator: LoginCoordinator) -> LoginViewContainer {
        let router = LoginViewModel.Router(
            showRegisterFlowHandler: { coordinator.showRegistrationFlow() },
            showMainFlowHandler: { coordinator.showMainFlow() }
        )
        let viewModel = LoginViewModel(
            router: router,
            loginUseCase: self.useCaseFactory
                .makeLoginUseCase(),
            validateEmailUseCase: self.useCaseFactory
                .makeValidateEmailUseCase(),
            validatePasswordUseCase: self.useCaseFactory
                .makeValidatePasswordUseCase()
        )
        return LoginViewContainer(viewModel: viewModel)
    }
}

extension ModuleFactory: RegistrationViewFactory
{
    @MainActor
    func makeRegistrationView(coordinator: RegistrationCoordinator) -> RegistrationViewContainer {
        let router = RegistrationViewModel.Router(
            signUpHandler: { coordinator.showLoginFlow() },
            showLoginFlowHandler: { coordinator.showLoginFlow() }
        )
        let viewModel = RegistrationViewModel(
            router: router,
            registrationUseCase: self.useCaseFactory.makeRegistrationUseCase(),
            validateEmailUseCase: self.useCaseFactory.makeValidateEmailUseCase(),
            validatePasswordUseCase: self.useCaseFactory.makeValidatePasswordUseCase(),
            validateNameUseCase: self.useCaseFactory.makeValidateNameUseCase()
        )
        return RegistrationViewContainer(viewModel: viewModel)
    }
}

extension ModuleFactory: MainProfileViewFactory
{
    func makeMainProfileView(coordinator: ProfileCoordinator) -> MainProfileViewContainer {
        let router = MainProfileViewModel.Router(
            logout: coordinator.logoutHandler,
            settingsHandler: coordinator.settingsHandler,
            profileDetailsHandler: coordinator.profileDetailsHandler
        )
        let viewModel = MainProfileViewModel(
            router: router,
            profileUseCase: self.useCaseFactory.makeMainProfileUseCase()
        )
        return MainProfileViewContainer(viewModel: viewModel)
    }
}

extension ModuleFactory: ProfileDetailsViewFactory
{
    func makeProfileDetailsView() -> ProfileDetailsContainer {
        return ProfileDetailsContainer()
    }
}

extension ModuleFactory: ProfileSettingsViewFactory
{
    func makeProfileSettingsView() -> ProfileSettingsContainer {
        return ProfileSettingsContainer()
    }
}

extension ModuleFactory: CoursesViewFactory
{
    func makeCoursesView() -> CoursesViewContainer {
        let viewModel = CasesViewModel()
        return CoursesViewContainer(viewModel: viewModel)
    }
}

extension ModuleFactory: HomeViewFactory
{
    func makeHomeView(coordinator: HomeCoordinator) -> HomeViewContainer {
        let viewModel = HomeViewModel()
        return HomeViewContainer(viewModel: viewModel)
    }
}

extension ModuleFactory: TransactionsViewFactory
{
    func makeTransactionsView() -> TransactionsViewContainer {
        let viewModel = TransactionsViewModel(useCase: self.useCaseFactory.makeTransactionsUseCase())
        return TransactionsViewContainer(viewModel: viewModel)
    }
}
