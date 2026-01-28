//
//  TransactionsRepository.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import Foundation

protocol TransactionsRepository
{
    func getTransactions() async throws -> [TransactionModel]
}
