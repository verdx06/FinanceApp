//
//  TransactionsCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import Foundation
import SwiftUI
import NavigationBackport

struct TransactionsCoordinatorView: View
{

    @ObservedObject
    private var coordinator: TransactionsCoordinator

    init(coordinator: TransactionsCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        NBNavigationStack(path: self.$coordinator.navigationPath) {
            self.coordinator.build(screen: .transactions)
                .nbNavigationDestination(for: TransactionsCoordinator.Screen.self) { screen in
                    switch screen {
                    case .transactions:
                        self.coordinator.build(screen: .transactions)
                    }
                }
        }
    }
}
