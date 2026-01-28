//
//  MainProfileViewModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 17.12.2025.
//

import Foundation

final class MainProfileViewModel: ObservableObject
{
    private let router: Router
    private let profileUseCase: MainProfileUseCaseProtocol
    private(set) var profileInformation = UserModel()

    init(router: Router, profileUseCase: MainProfileUseCaseProtocol) {
        self.router = router
        self.profileUseCase = profileUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .onAppear:
            self.handleOnAppear()
        case .editButtonTapped:
            self.profileDetailsTapped()
        case .settingsButtonTapped:
            self.settingsTapped()
        case .logoutButtonTapped:
            self.handleLogout()
        }
    }
}

private extension MainProfileViewModel
{
    func handleOnAppear() {
        Task {
            do {
                self.profileInformation = try await self.profileUseCase.execute()
            } catch {}
        }
    }
    func handleLogout() {self.router.logout()}
    func settingsTapped() {self.router.settingsHandler()}
    func profileDetailsTapped() {self.router.profileDetailsHandler()}
}
