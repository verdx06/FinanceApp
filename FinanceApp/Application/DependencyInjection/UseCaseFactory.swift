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

    func makeRegistrationUseCase() -> RegistrationUseCaseProtocol {
        RegistrationUseCase(authRepository: self.repositoryFactory.authRepository)
    }
}

extension UseCaseFactory
{
    func makeValidateEmailUseCase() -> ValidateEmailUseCaseProtocol {
        ValidateEmailUseCase()
    }

    func makeValidatePasswordUseCase() -> ValidatePasswordUseCaseProtocol {
        ValidatePasswordUseCase()
    }

    func makeValidateNameUseCase() -> ValidateNameUseCaseProtocol {
        ValidateNameUseCase()
    }
}

extension UseCaseFactory
{
    func makeTransactionsUseCase() -> TransactionsUseCase {
        TransactionsUseCase(repository: self.repositoryFactory.transactionsRepository)
    }
}
