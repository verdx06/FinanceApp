//
//  TransactionsList+State.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 21.01.2026.
//

import Foundation

typealias TransactionsSection = (
    dayStart: Date,
    title: String,
    items: [TransactionModel]
)

enum TransactionsListState
{
    case idle
    case loading
    case loaded(sections: [TransactionsSection])
    case noTransactions
}
