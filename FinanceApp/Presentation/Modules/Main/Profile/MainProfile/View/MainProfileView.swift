//
//  MainProfileView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

import SwiftUI

struct MainProfileView: View
{
    @ObservedObject
    var viewModel: MainProfileViewModel

    var size: CGSize
    var safeArea: EdgeInsets
    @State var offsetY: CGFloat = 0

    init(viewModel: MainProfileViewModel, size: CGSize, safeArea: EdgeInsets) {
        self.viewModel = viewModel
        self.size = size
        self.safeArea = safeArea
    }

    var body: some View {
        ScrollView {
            VStack {
                HeaderView(
                    size: size,
                    safeArea: safeArea,
                    offsetY: offsetY,
                    headerHeight: 65
                ) { _ in
                    Text("Profile")
                        .font(.system(size: 32, weight: .semibold))
                }
                    .zIndex(1000)
                VStack {
                    Circle()
                        .frame(width: 150)
                    Text("John Smeet")
                        .bold()
                        .font(.system(size: 25))
                    HStack {
                        VStack(alignment: .leading, spacing: 25){
                            ProfileButton(type: .edit) { self.viewModel.handle(.editButtonTapped) }
                            ProfileButton(type: .settings) { self.viewModel.handle(.settingsButtonTapped) }
                            ProfileButton(type: .logout) { self.viewModel.handle(.logoutButtonTapped) }
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                .padding(.top, 65 + safeArea.top)
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
    ModuleFactory(useCaseFactory: UseCaseFactory(repositoryFactory: RepositoryFactory()))
        .makeMainProfileView(
            coordinator: ProfileCoordinator(
                logoutFlowHandler: {},
                modularFactory: ModuleFactory(useCaseFactory: UseCaseFactory(repositoryFactory: RepositoryFactory())))
        )
}
