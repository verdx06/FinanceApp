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
            CustomTextField(fieldType: .name, text: .constant(""))
            CustomTextField(fieldType: .email, text: .constant(""))
            CustomTextField(fieldType: .phoneNumber, text: .constant(""))
            CustomTextField(fieldType: .password, text: .constant(""))
            CustomTextField(fieldType: .password, text: .constant(""))
        }.padding(.horizontal)
    }

    var buttons: some View {
        VStack {
            Button {
                self.viewModel.handle(.signUpButtomTapped)
            } label: {
                Text("Sign Up")
            }.mainAuthButtonStyle()

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
