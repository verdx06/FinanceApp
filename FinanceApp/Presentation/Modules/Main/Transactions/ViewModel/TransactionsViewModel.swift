//
//  TransactionsViewModel.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import Foundation

@MainActor
final class TransactionsViewModel: ObservableObject
{
    @Published
    private(set) var balance: Float = 0
    @Published
    private(set) var income: Float = 0
    @Published
    private(set) var expense: Float = 0

    private var allTransactions: [TransactionModel] = []
    private var fetchingTransactions: Task<Void, Error>?

    @Published
    var offsetY: CGFloat = 0

    @Published
    private(set) var typeView: OperationType = .all
    @Published
    private(set) var transactionsListState: TransactionsListState

    private let useCase: TransactionsUseCase

    init(useCase: TransactionsUseCase) {
        self.transactionsListState = .idle
        self.useCase = useCase
    }

    func handle(_ event: Event) {
        switch event {
        case .tapIncome:
            self.handleTapIncome()
        case .tapExpense:
            self.handleTapExpense()
        case .onAppear:
            self.handleOnAppear()
        }
    }
}

private extension TransactionsViewModel
{
    private static let sectionTitleFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.calendar = Calendar(identifier: .iso8601)
        f.timeZone = TimeZone(secondsFromGMT: 0)
        f.dateFormat = "d MMMM"
        return f
    }()

    private static var sectionCalendar: Calendar {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        return calendar
    }

    func handleOnAppear() {
        self.fetchingTransactions = Task { [weak self] in
            await self?.fetchTransactions()
        }
    }

    func fetchTransactions() async {
        do {
            self.transactionsListState = .loading
            let loadedTransactions = try await self.useCase.getTransactions()
            self.allTransactions = loadedTransactions
            self.recalculateTotals(from: loadedTransactions)
            if loadedTransactions.isEmpty {
                self.transactionsListState = .noTransactions
            } else {
                self.applyFilterAndUpdateState()
            }
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }

    func handleTapIncome() {
        self.typeView = (typeView != .income) ? .income : .all
        self.applyFilterAndUpdateState()
    }

    func handleTapExpense() {
        self.typeView = (typeView != .expense) ? .expense : .all
        self.applyFilterAndUpdateState()
    }

    func applyFilterAndUpdateState() {
        guard self.allTransactions.isEmpty == false else { return }

        let filtered: [TransactionModel]
        switch self.typeView {
        case .all:
            filtered = self.allTransactions
        case .income:
            filtered = self.allTransactions.filter { $0.transactionType == .income }
        case .expense:
            filtered = self.allTransactions.filter { $0.transactionType == .expense }
        }

        let sorted = filtered.sorted { $0.occurredAt > $1.occurredAt }
        let sections = self.makeSections(from: sorted)

        self.transactionsListState = sections.isEmpty
            ? .noTransactions
        : .loaded(sections: sections)
    }

    func recalculateTotals(from transactions: [TransactionModel]) {
        let income = transactions
            .filter { $0.transactionType == .income }
            .reduce(0.0) { $0 + $1.amount }

        let expense = transactions
            .filter { $0.transactionType == .expense }
            .reduce(0.0) { $0 + $1.amount }

        self.income = Float(income)
        self.expense = Float(expense)
        self.balance = Float(income - expense)
    }

    func makeSections(from transactions: [TransactionModel]) -> [TransactionsSection] {
        let calendar = Self.sectionCalendar
        let groups = Dictionary(grouping: transactions) {
            calendar.startOfDay(for: $0.occurredAt)
        }
        let sortedKeys = groups.keys.sorted(by: >)

        return sortedKeys.map { key in
            (
                dayStart: key,
                title: Self.sectionTitleFormatter.string(from: key),
                items: groups[key] ?? []
            )
        }
    }
}
