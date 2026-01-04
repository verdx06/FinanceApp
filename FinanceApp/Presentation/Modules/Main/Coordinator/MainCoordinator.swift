//
//  MainCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import Foundation

final class MainCoordinator: ObservableObject
{
    enum Tab
    {
        case home
        case profile
        case transactions
        case analytics
        case cases
    }

    @Published
    var selectedTab: Tab = .home
}
