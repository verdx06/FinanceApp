//
//  HomeViewModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 27.12.2025.
//

import Foundation

final class HomeViewModel: ObservableObject
{
    private(set) var balance: Float = 0
    private(set) var income: Float = 0
    private(set) var expenditure: Float = 0

    @Published
    var offsetY: CGFloat = 0

    @Published
    private(set) var typeView: OperationType = .all

    func typeIncome() {
        typeView = typeView != .income ? .income : .all
    }

    func typeExpenditure() {
        typeView = typeView != .expenditure ? .expenditure : .all
    }
}
