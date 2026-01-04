//
//  CoordinatorFactoryProtocols.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 06.10.2025.
//

import Foundation

// MARK: - Auth
typealias LoginCoordinatorFactory = LoginViewFactory
typealias RegistrationCoordinatorFactory = RegistrationViewFactory

typealias AuthCoordinatorFactory =
    LoginCoordinatorFactory &
    RegistrationCoordinatorFactory

// MARK: - Main
typealias ProfileCoordinatorFactory = MainProfileViewFactory & ProfileDetailsViewFactory & ProfileSettingsViewFactory
typealias CoursesCoordinatorFactory = CoursesViewFactory
typealias HomeCoordinatorFactory = HomeViewFactory
