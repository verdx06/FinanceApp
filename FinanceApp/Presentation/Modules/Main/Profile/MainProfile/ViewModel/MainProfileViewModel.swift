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

    init(router: Router) {
        self.router = router
    }

    func handle(_ event: Event) {
        switch event {
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
    func handleLogout() {
        UserDefaults.standard.set(false, forKey: "login")
        self.router.logout()
    }
    func settingsTapped() {self.router.settingsHandler()}
    func profileDetailsTapped() {self.router.profileDetailsHandler()}
}
