//
//  RegistrationView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.10.2025.
//

import SwiftUI

struct RegistrationView: View
{
    @ObservedObject
    private var viewModel: RegistrationViewModel

    var size: CGSize
    var safeArea: EdgeInsets
    @State var offsetY: CGFloat = 0

    init(viewModel: RegistrationViewModel, size: CGSize, safeArea: EdgeInsets) {
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
                    Text("Create Account")
                        .font(.system(size: 32, weight: .semibold))
                }
                    .zIndex(1000)
                VStack {
                    self.fields

                    self.buttons
                }
                .padding(.vertical, 65 + safeArea.top)
            }.background {
                ScrollDetector { offset in
                    offsetY = -offset
                } onDraggingEnd: { _, _ in
                }
            }
        }
        .alert(isPresented: self.$viewModel.isAlert) {
            Alert(
                title: Text("Ошибка"),
                message: Text(self.viewModel.state.alertError),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ModuleFactory(
        useCaseFactory: UseCaseFactory(
            repositoryFactory: RepositoryFactory()
        )
    )
    .makeRegistrationView(
        coordinator: RegistrationCoordinator(
            showLoginFlowHandler: {
            })
    )
}

private extension RegistrationView
{
    var fields: some View {
        VStack {
            CustomTextField(fieldType: .name, text: self.name, error: self.viewModel.state.name.error)
            CustomTextField(fieldType: .email, text: self.email, error: self.viewModel.state.email.error)
            CustomTextField(fieldType: .password, text: self.password, error: self.viewModel.state.password.error)
        }.padding(.horizontal)
    }

    var buttons: some View {
        VStack {
            Button {
                self.viewModel.handle(.signUpButtomTapped)
            } label: {
                Text("Sign Up")
            }
            .padding(.horizontal)
            .mainAuthButtonStyle(isLoading: self.viewModel.state.registrationState == .loading)

            HStack {
                Text("Already have an account?")
                    .font(.system(size: 14))
                Button {
                    self.viewModel.handle(.loginButtonTapped)
                } label: {
                    Text("Log In")
                        .foregroundStyle(.blue)
                        .font(.system(size: 14))
                }
            }.padding(.top)
        }.padding(.top, 30)
    }
}

private extension RegistrationView
{
    var name: Binding<String> {
        Binding(
            get: { self.viewModel.state.name.content },
            set: { self.viewModel.handle(.nameChanged(name: $0)) }
        )
    }

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
