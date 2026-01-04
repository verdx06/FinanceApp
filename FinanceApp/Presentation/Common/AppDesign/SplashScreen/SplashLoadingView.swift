//
//  SplashLoadingView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import SwiftUI

struct SplashLoadingView: View
{
    @State private var colorBackground: Color = .caribbeanGreen

    var body: some View {
        ZStack {
            colorBackground.ignoresSafeArea()
            VStack {
                Image("appImage")
            }
        }
    }
}

#Preview {
    SplashLoadingView()
}
