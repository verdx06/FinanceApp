//
//  HeaderView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.10.2025.
//

import SwiftUI

struct HeaderView<Content: View>: View
{
    var size: CGSize
    var safeArea: EdgeInsets
    var offsetY: CGFloat
    var headerHeight: CGFloat
    var minHeaderHeight: CGFloat = 65
    var background: Color = .caribbeanGreen
    @ViewBuilder var content: (_ progress: CGFloat) -> Content

    var body: some View {
        let fullHeader = headerHeight + safeArea.top
        let minimumHeader = minHeaderHeight + safeArea.top
        let progress = max(min(-offsetY / (fullHeader - minimumHeader), 1), 0)

        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(background)

                VStack(spacing: 12) {
                    content(progress)
                }
                .padding(.top, safeArea.top)
            }
            .frame(
                height: (fullHeader + offsetY) < minimumHeader
                    ? minimumHeader
                    : (fullHeader + offsetY),
                alignment: .bottom
            )
            .offset(y: -offsetY)
        }
    }
}
