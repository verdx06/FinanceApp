//
//  HomeCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import Foundation
import SwiftUI

final class HomeCoordinator: ObservableObject
{
    enum Screen
    {
        case home
    }

    @Published
    var navigationPath: [Screen] = []

    private let modularFactory: HomeCoordinatorFactory

    init(modularFactory: HomeCoordinatorFactory) {
        self.modularFactory = modularFactory
    }
}

extension HomeCoordinator
{
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .home:
            self.modularFactory.makeHomeView(coordinator: self)
        }
    }
}
