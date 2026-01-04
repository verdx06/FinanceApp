//
//  MainProfileViewContainer.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import SwiftUI

struct MainProfileViewContainer: View
{
    @ObservedObject
    private var viewModel: MainProfileViewModel

    init(viewModel: MainProfileViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            MainProfileView(viewModel: self.viewModel, size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}
