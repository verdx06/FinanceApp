//
//  TransactionsUseCase.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import Foundation

protocol TransactionsUseCaseProtocol
{
    func getTransactions() async throws -> [TransactionModel]
}

struct TransactionsUseCase
{
    private let repository: TransactionsRepository

    init(repository: TransactionsRepository) {
        self.repository = repository
    }
}

extension TransactionsUseCase: TransactionsUseCaseProtocol
{
    func getTransactions() async throws -> [TransactionModel] {
        try await self.repository.getTransactions()
    }
}
