//
//  Date+Formatting.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 21.01.2026.
//

import SwiftUI

extension String
{
    var monthTitleRu: String {
        let parser = DateFormatter()
        parser.calendar = Calendar(identifier: .iso8601)
        parser.timeZone = TimeZone(secondsFromGMT: 0)
        parser.dateFormat = "yyyy-MM-dd"

        guard let date = parser.date(from: self) else { return self }

        let month = DateFormatter()
        month.dateFormat = "LLLL"
        return month.string(from: date).capitalized
    }
}
