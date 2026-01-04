//
//  HomeView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 25.12.2025.
//

import SwiftUI

struct HomeView: View
{
    @ObservedObject var viewModel: HomeViewModel
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
                    Text("Home")
                        .font(.system(size: 32, weight: .semibold))

                    self.balance(
                        balanceScale: 1 - (progress * 0.25),
                        balanceOffset: progress * 120
                    )

                    self.buttons(
                        progress: progress
                    )
                }
                .zIndex(1000)
            }.background {
                ScrollDetector { offset in
                    self.viewModel.offsetY = -offset
                } onDraggingEnd: { _, _ in
                }
            }
        }
    }
}

private extension HomeView
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
                        self.viewModel.typeIncome()
                    }
                }
            )
            Spacer()
            operation(
                icon: "arrow.down.right.square",
                iconColor: self.viewModel.typeView == .expenditure ? .white : .red,
                title: "Расход",
                value: self.viewModel.expenditure,
                activeColor: self.viewModel.typeView == .expenditure ? .oceanBlue : .white,
                colorText: self.viewModel.typeView == .expenditure ? .white : .black,
                action: {
                    withAnimation {
                        self.viewModel.typeExpenditure()
                    }
                }
            )
            Spacer()
        }
        .scaleEffect(1 - progress)
        .opacity(1 - progress)
        .padding(.horizontal, 10)
        .padding(.bottom)
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
        .padding(.horizontal)
        .offset(y: balanceOffset)
    }
}

#Preview {
    HomeViewContainer(viewModel: HomeViewModel())
}
