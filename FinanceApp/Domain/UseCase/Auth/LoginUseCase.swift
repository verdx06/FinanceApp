//
//  LoginUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

protocol LoginUseCaseProtocol: AnyObject
{
    func execute(credentials: AuthCredentials) async throws
}

final class LoginUseCase
{
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}

extension LoginUseCase: LoginUseCaseProtocol
{
    func execute(credentials: AuthCredentials) async throws {
        try await self.authRepository.login(credentials: credentials)
    }
}
