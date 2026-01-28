//
//  TransactionsCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import Foundation
import SwiftUI

final class TransactionsCoordinator: ObservableObject
{
    enum Screen
    {
        case transactions
    }

    @Published
    var navigationPath: [Screen] = []

    private let moduleFactory: TransactionsCoordinatorFactory

    init(moduleFactory: TransactionsCoordinatorFactory) {
        self.moduleFactory = moduleFactory
    }
}

extension TransactionsCoordinator
{
    @MainActor
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .transactions:
            self.moduleFactory.makeTransactionsView()
        }
    }
}
