//
//  LoginView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 05.10.2025.
//

import SwiftUI

struct LoginView: View
{
    @ObservedObject private var viewModel: LoginViewModel
    var size: CGSize
    var safeArea: EdgeInsets
    @State var offsetY: CGFloat = 0

    init(viewModel: LoginViewModel, size: CGSize, safeArea: EdgeInsets) {
        self.viewModel = viewModel
        self.size = size
        self.safeArea = safeArea
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeaderView(
                    size: size,
                    safeArea: safeArea,
                    offsetY: offsetY,
                    headerHeight: 65
                ) { _ in
                    Text("Welcome")
                        .font(.system(size: 32, weight: .semibold))
                }
                    .zIndex(1000)

                VStack(spacing: 0) {
                    self.fields
                        .padding(.horizontal)

                    self.buttons
                        .padding(.top, 60)
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
    ModuleFactory(
        useCaseFactory: UseCaseFactory(
            repositoryFactory: RepositoryFactory()
        )
    )
    .makeLoginView(
        coordinator: LoginCoordinator(
            showRegistrationFlowHandler: {
            },
            showMainFlowHandler: {
            }
        )
    )
}

private extension LoginView
{
    var email: Binding<String> {
        Binding(
            get: { self.viewModel.state.email.content },
            set: { self.viewModel.handle(.emailChanged(email: $0)) }
        )
    }

    var password: Binding<String> {
        Binding(
            get: { self.viewModel.state.password.content },
            set: { self.viewModel.handle(.passwordChanged(password: $0)) }
        )
    }
}

private extension LoginView
{
    var buttons: some View {
        VStack(spacing: 15) {
            Button {
                self.viewModel.handle(.loginTapped)
            } label: {
                if self.viewModel.state.loginState == .loading {
                    ProgressView()
                } else {
                    Text("Log In")
                }
            }
            .mainAuthButtonStyle(isLoading: self.viewModel.state.loginState == .loading)
            .disabled(self.viewModel.state.loginState == .loading)
            .padding(.horizontal, 30)
            Spacer()
            HStack {
                Text("Dont have account?")
                    .font(.system(size: 14))
                Button {
                    self.viewModel.handle(.signupTapped)
                } label: {
                    Text("Sign up")
                        .foregroundStyle(.blue)
                        .font(.system(size: 14))
                }
            }.padding(.top)
        }
    }

    @ViewBuilder
    var fields: some View {
        CustomTextField(
            fieldType: .email,
            text: self.email,
            error: self.viewModel.state.email.error
        )
        CustomTextField(
            fieldType: .password,
            text: self.password,
            error: self.viewModel.state.password.error
        )
    }
}
