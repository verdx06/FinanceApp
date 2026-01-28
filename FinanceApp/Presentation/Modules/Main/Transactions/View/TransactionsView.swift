//
//  TransactionsView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import SwiftUI

struct TransactionsView: View
{
    @ObservedObject var viewModel: TransactionsViewModel
    var size: CGSize
    var safeArea: EdgeInsets

    var body: some View {
        ScrollView {
            VStack {
                HeaderView(
                    size: size,
                    safeArea: safeArea,
                    offsetY: self.viewModel.offsetY,
                    headerHeight: size.height * 0.45
                ) { progress in
                    Text("Transactions")
                        .font(.system(size: 32, weight: .semibold))

                    self.balance(
                        balanceScale: 1 - (progress * 0.25),
                        balanceOffset: progress * 145
                    )

                    self.buttons(
                        progress: progress
                    )
                }
                .zIndex(1000)
                TransactionsListView(state: self.viewModel.transactionsListState)
                    .padding(15)
            }
            .onAppear {
                self.viewModel.handle(.onAppear)
            }
            .background {
                ScrollDetector { offset in
                    self.viewModel.offsetY = -offset
                } onDraggingEnd: { _, _ in
                }
            }
        }
    }
}

private extension TransactionsView
{
    func operation(
        icon: String,
        iconColor: Color,
        title: String,
        value: Float,
        activeColor: Color,
        colorText: Color,
        action: @escaping () -> Void
    ) -> some View {
        VStack {
            Button {
                action()
            } label: {
                VStack {
                    Image(systemName: icon)
                        .font(.system(size: 32))
                        .foregroundStyle(iconColor)
                    Text(title)
                        .font(.title3)
                        .foregroundStyle(colorText)
                    Text("\(String(format: "%.2f", value)) ₽")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(colorText)
                }
            }
            .operationButtonStyle(activeColor: activeColor, colorText: colorText)
        }
    }

    func buttons(progress: CGFloat) -> some View {
        HStack {
            Spacer()
            operation(
                icon: "arrow.up.right.square",
                iconColor: self.viewModel.typeView == .income ? .white : .caribbeanGreen,
                title: "Доход",
                value: self.viewModel.income,
                activeColor: self.viewModel.typeView == .income ? .oceanBlue : .white,
                colorText: self.viewModel.typeView == .income ? .white : .black,
                action: {
                    withAnimation {
                        self.viewModel.handle(.tapIncome)
                    }
                }
            )
            Spacer()
            operation(
                icon: "arrow.down.right.square",
                iconColor: self.viewModel.typeView == .expense ? .white : .red,
                title: "Расход",
                value: self.viewModel.expense,
                activeColor: self.viewModel.typeView == .expense ? .oceanBlue : .white,
                colorText: self.viewModel.typeView == .expense ? .white : .black,
                action: {
                    withAnimation {
                        self.viewModel.handle(.tapExpense)
                    }
                }
            )
            Spacer()
        }
        .scaleEffect(1 - progress)
        .opacity(1 - progress)
    }

    func balance(balanceScale: CGFloat, balanceOffset: CGFloat) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 75)
                .foregroundStyle(.white)
                .scaleEffect(balanceScale)
            VStack {
                Text("Balance")
                    .foregroundStyle(.black)
                Text("\(String(format: "%.2f", self.viewModel.balance)) ₽")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, 30)
        .offset(y: balanceOffset)
    }
}

#Preview {
    ModuleFactory(useCaseFactory:
                    UseCaseFactory(repositoryFactory:
                                    RepositoryFactory())).makeTransactionsView()
}
