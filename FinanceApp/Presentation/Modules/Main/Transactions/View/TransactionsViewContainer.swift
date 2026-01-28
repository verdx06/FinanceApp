//
//  TransactionsViewContainer.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 20.01.2026.
//

import SwiftUI

struct TransactionsViewContainer: View
{
    @StateObject
    var viewModel: TransactionsViewModel

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            TransactionsView(viewModel: self.viewModel, size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    HomeViewContainer(
        viewModel: HomeViewModel()
    )
}
