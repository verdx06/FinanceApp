//
//  Double.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 28.01.2026.
//

import SwiftUI

extension Double
{
    var twoDecimalFormat: String {
        String(format: "%.2f", self)
    }
}
