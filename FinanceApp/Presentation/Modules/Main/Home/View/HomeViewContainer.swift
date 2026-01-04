//
//  HomeViewContainer.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 25.12.2025.
//

import SwiftUI

struct HomeViewContainer: View
{
    @StateObject
    var viewModel: HomeViewModel

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            HomeView(viewModel: self.viewModel, size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    HomeViewContainer(
        viewModel: HomeViewModel()
    )
}
