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
    func signup(user: UserRegistration) async throws {
        try await self.networkService
            .signUp(
                name: user.name,
                phone: user.phoneNumber,
                email: user.email,
                password: user.password
            )
    }

    func login(credentials: AuthCredentials) async throws {
        try await self.networkService.signIn(email: credentials.email, password: credentials.password)
    }
}
