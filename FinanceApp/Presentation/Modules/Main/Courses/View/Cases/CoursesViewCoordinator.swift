//
//  CoursesViewContainer.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 21.12.2025.
//

import SwiftUI

struct CoursesViewContainer: View
{
    @StateObject
    var viewModel: CasesViewModel

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            let safeArea = geo.safeAreaInsets

            CoursesView(viewModel: self.viewModel, size: size, safeArea: safeArea)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    CoursesViewContainer(viewModel: CasesViewModel())
}
