//
//  CoursesCoordinator.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 21.12.2025.
//

import SwiftUI

final class CoursesCoordinator: ObservableObject
{
    enum Screen
    {
        case cases
    }

    @Published
    var navigationPath: [Screen] = []

    private let modularFactory: CoursesCoordinatorFactory

    init(modularFactory: CoursesCoordinatorFactory) {
        self.modularFactory = modularFactory
    }
}

extension CoursesCoordinator
{
    @MainActor
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .cases:
            self.modularFactory.makeCoursesView()
        }
    }
}
