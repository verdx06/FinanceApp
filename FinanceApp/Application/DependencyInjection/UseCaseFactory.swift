//
//  UseCaseFactory.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 04.01.2026.
//

import Foundation

final class UseCaseFactory
{
    private let repositoryFactory: RepositoryFactory

    init(repositoryFactory: RepositoryFactory) {
        self.repositoryFactory = repositoryFactory
    }
}

extension UseCaseFactory
{
    func makeLoginUseCase() -> LoginUseCaseProtocol {
        LoginUseCase(authRepository: self.repositoryFactory.authRepository)
    }
}

extension UseCaseFactory
{
    func makeValidateEmailUseCase() -> ValidateAuthUseCaseProtocol {
        ValidateAuthUseCase()
    }
}
