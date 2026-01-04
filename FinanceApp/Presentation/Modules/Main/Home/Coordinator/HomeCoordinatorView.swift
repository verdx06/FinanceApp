//
//  HomeCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import SwiftUI
import NavigationBackport

struct HomeCoordinatorView: View
{

    @ObservedObject
    private var coordinator: HomeCoordinator

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NBNavigationStack(path: self.$coordinator.navigationPath) {
            self.coordinator.build(.home)
        }
    }
}
