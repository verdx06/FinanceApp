//
//  CoursesView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 21.12.2025.
//

import SwiftUI

struct CoursesView: View
{

    @ObservedObject
    var viewModel: CasesViewModel

    var size: CGSize
    var safeArea: EdgeInsets
    @State var offsetY: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack {
                HeaderView(
                    size: size,
                    safeArea: safeArea,
                    offsetY: offsetY,
                    headerHeight: 65
                ) { _ in
                    Text("Курсы")
                        .font(.system(size: 32, weight: .semibold))
                }
                    .zIndex(1000)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(0...11, id: \.self) { _ in
                        AsyncImage(url: URL(string: "https://mytishchi.clean-clinic.ru/upload/iblock/667/nmpofdx6v813kjqxaghdiu6rbatayhbm.jpg"))
                            .frame(width: 120, height: 180)
                                        .background(Color.gray.opacity(0.15))
                                        .cornerRadius(10)
                    }
                }
                .padding(.top, 65 + safeArea.top)
                .padding()
            }.background {
                ScrollDetector { offset in
                    offsetY = -offset
                } onDraggingEnd: { _, _ in
                }
            }
        }
    }
}

#Preview {
    CoursesViewContainer(viewModel: CasesViewModel())
}
