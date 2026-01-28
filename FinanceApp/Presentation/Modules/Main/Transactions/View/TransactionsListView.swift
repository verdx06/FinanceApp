//
//  TransactionsListView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import SwiftUI

struct TransactionsListView: View
{
    private var state: TransactionsListState

    init(state: TransactionsListState) {
        self.state = state
    }

    var body: some View {
        switch state {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .loaded(let sections):
            ForEach(sections, id: \.dayStart) { section in
                HStack {
                    Text(section.title)
                        .font(.bold22)
                    Spacer()
                }

                ForEach(section.items) { transaction in
                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 22)
                                .frame(width: Constants.iconWidth, height: Constants.iconHeight)
                                .foregroundStyle(Color.lightBlue)
                            Image(systemName: transaction.categoryImage)
                                .resizable()
                                .foregroundStyle(Color.white)
                                .scaledToFit()
                                .frame(width: Constants.iconImageWidth,
                                       height: Constants.iconImageHeight)
                        }
                        VStack(alignment: .leading) {
                            Text(transaction.category)
                                .font(.semibold20)
                            Text(transaction.description ?? "")
                                .font(.regular14)
                                .foregroundStyle(Color.secondary)
                        }
                        Spacer()

                        Text(transaction.signedAmountText)
                            .foregroundStyle(transaction.colorForTransaction)
                    }
                }
            }
        case .noTransactions:
            Text("Нет транзакций")
        }
    }
}

private extension TransactionsListView
{
    enum Constants
    {
        static let iconWidth: CGFloat = 57
        static let iconHeight: CGFloat = 53
        static let iconImageWidth: CGFloat = 26
        static let iconImageHeight: CGFloat = 23
        static let amountWidth: CGFloat = 80
        static let separatorWidth: CGFloat = 1
        static let separatorHeight: CGFloat = 35
    }
}
