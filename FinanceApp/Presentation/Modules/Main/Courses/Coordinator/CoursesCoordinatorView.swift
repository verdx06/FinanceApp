//
//  CoursesCoordinatorView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 21.12.2025.
//

import SwiftUI
import NavigationBackport

struct CoursesCoordinatorView: View
{

    @ObservedObject
    private var coursesCoordinator: CoursesCoordinator

    init(coursesCoordinator: CoursesCoordinator) {
        self.coursesCoordinator = coursesCoordinator
    }

    var body: some View {
        NBNavigationStack(path: self.$coursesCoordinator.navigationPath) {
            self.coursesCoordinator.build(screen: .cases)
                .nbNavigationDestination(for: CoursesCoordinator.Screen.self) { screen in
                    switch screen {
                    case .cases:
                        self.coursesCoordinator.build(screen: .cases)
                    }
                }
        }
    }
}
