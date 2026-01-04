//
//  RepositoryFactory.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

final class RepositoryFactory
{
    lazy var networkService = SupabaseManager()
    lazy var authRepository = AuthRepositoryImpl(networkService: self.networkService)
}
