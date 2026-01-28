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
            Text("Home")
        }
    }
}

#Preview {
    HomeViewContainer(viewModel: HomeViewModel())
}
