//
//  AuthRepositoryImpl.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

final class AuthRepositoryImpl
{
    private let networkService: SupabaseManager

    init(networkService: SupabaseManager) {
        self.networkService = networkService
    }
}

extension AuthRepositoryImpl: AuthRepository
{
    func login(credentials: AuthCredentials) async throws {
        try await networkService.signIn(email: credentials.email, password: credentials.password)
    }
}
