//
//  RegistrationUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 06.01.2026.
//

import Foundation

protocol RegistrationUseCaseProtocol
{
    func execute(_ user: UserRegistration) async throws
}

final class RegistrationUseCase
{
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}

extension RegistrationUseCase: RegistrationUseCaseProtocol
{
    func execute(_ user: UserRegistration) async throws {
        try await self.authRepository.signup(user: user)
    }
}
