//
//  ProfileButton.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 17.12.2025.
//

import SwiftUI

struct ProfileButton: View
{
    let type: TypeButtonStyle
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.lightBlue)
                        .frame(width: 57, height: 53)
                    switch type {
                    case .edit:
                        Image("profile")
                    case .settings:
                        Image("setting")
                    case .logout:
                        Image("logout")
                    }
                }
                switch type {
                case .edit:
                    Text("Edit profile")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                case .settings:
                    Text("Setting")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                case .logout:
                    Text("Logout")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

extension ProfileButton
{
    enum TypeButtonStyle
    {
        case edit
        case settings
        case logout
    }
}

#Preview {
    ProfileButton(type: .edit, action: {})
}
