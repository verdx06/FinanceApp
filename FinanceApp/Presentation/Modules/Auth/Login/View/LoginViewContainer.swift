//
//  LoginViewContainer.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import SwiftUI

struct LoginViewContainer: View
{
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let safeArea = geo.safeAreaInsets

            LoginView(viewModel: self.viewModel, size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}
