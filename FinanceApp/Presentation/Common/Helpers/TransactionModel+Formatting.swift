//
//  TransactionModel+Formatting.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 28.01.2026.
//

import Foundation
import SwiftUI

// MARK: - UI helpers
extension TransactionModel
{
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .iso8601)
        f.timeZone = TimeZone(secondsFromGMT: 0)
        f.dateFormat = "HH:mm"
        return f
    }()

    private static let dayMonthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .iso8601)
        f.timeZone = TimeZone(secondsFromGMT: 0)
        f.dateFormat = "d MMMM"
        return f
    }()

    var timeText: String { Self.timeFormatter.string(from: occurredAt) }
    var dayMonthText: String { Self.dayMonthFormatter.string(from: occurredAt) }

    var signedAmountText: String {
        let operation = self.transactionType == .expense ? "-" : "+"
        return "\(operation)\(self.amount.twoDecimalFormat) ₽"
    }

    var colorForTransaction: Color {
        switch transactionType {
        case .income:
            .green
        case .expense:
            .primary
        }
    }
}
