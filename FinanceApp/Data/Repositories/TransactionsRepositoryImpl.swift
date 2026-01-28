//
//  TransactionsRepositoryImpl.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import Foundation

final class TransactionsRepositoryImpl
{
    private let networkService: SupabaseManager

    init(networkService: SupabaseManager) {
        self.networkService = networkService
    }
}

extension TransactionsRepositoryImpl: TransactionsRepository
{
    func getTransactions() async throws -> [TransactionModel] {
        try await self.networkService.getTransactions()
    }
}
