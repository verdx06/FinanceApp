//
//  TransactionsModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import Foundation

struct TransactionModel: Identifiable, Codable, Equatable
{
    let id: Int
    let userId: UUID
    let amount: Double
    let category: String
    let categoryImage: String
    let description: String?
    let occurredAt: Date
    let monthStart: String
    let transactionType: TransactionType
    let createdAt: Date

    enum CodingKeys: String, CodingKey
    {
        case id
        case userId = "user_id"
        case amount
        case category
        case categoryImage = "category_image"
        case description
        case occurredAt = "occurred_at"
        case monthStart = "month_start"
        case transactionType = "transaction_type"
        case createdAt = "created_at"
    }
}
