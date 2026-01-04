//
//  RegistrationViewContainer.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.10.2025.
//

import SwiftUI

struct RegistrationViewContainer: View
{

    @StateObject var viewModel: RegistrationViewModel

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let safeArea = geo.safeAreaInsets

            RegistrationView(viewModel: self.viewModel, size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}
