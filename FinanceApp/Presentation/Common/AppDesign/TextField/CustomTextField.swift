//
//  CustomTextField.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 15.10.2025.
//

import SwiftUI

struct CustomTextField: View
{
    let fieldType: FieldType
    @Binding var text: String
    let error: String?
    @State private var isPasswordVisible: Bool = false

    init(
        fieldType: FieldType,
        text: Binding<String>,
        error: String? = nil
    ) {
        self.fieldType = fieldType
        self._text = text
        self.error = error
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Metrics.contentSpacing) {
            HStack(spacing: Metrics.hStackSpacing) {
                Text(fieldType.header)
                    .foregroundStyle(style.headerColor)
                    .font(.semibold12)

                if fieldType.isRequired {
                    Text(verbatim: "*")
                        .foregroundStyle(Color(.red))
                        .font(.semibold12)
                }
            }

            HStack {
                Group {
                    if fieldType.isSecure {
                        if isPasswordVisible {
                            TextField(fieldType.placeholder, text: $text)
                        } else {
                            SecureField(fieldType.placeholder, text: $text)
                        }
                    } else {
                        TextField(fieldType.placeholder, text: $text)
                            .keyboardType(fieldType.keyboardType)
                    }
                }
                .font(.formTextField)
                .frame(maxWidth: .infinity, alignment: .leading)

                if fieldType.isSecure {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(isPasswordVisible ? "EyeOn" : "EyeOff")
                            .resizable()
                            .frame(width: 24, height: 12)
                    }
                    .padding(.trailing, 4)
                }
            }
            .padding(Metrics.textFieldPadding)
            .background(Color.lightGreen)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: Metrics.cornerRadius)
                    .stroke(style.borderColor, lineWidth: Metrics.borderWidth)
            )

            if let error = error, error.isEmpty == false {
                Text(error)
                    .font(.system(size: Metrics.errorFontSize, weight: .medium))
                    .foregroundStyle(Color.error)
                    .animation(.bouncy, value: error)
            }
        }
        .padding(Metrics.contentPadding)
    }

    private var style: FormItemStyle {
        if error != nil {
            return .error
        } else {
            return .default
        }
    }
}

// MARK: - Form Item Style
private enum FormItemStyle
{
    case `default`
    case readonly
    case error

    var headerColor: Color {
        switch self {
        case .default, .readonly: Color.onSurface
        case .error: Color.error
        }
    }

    var borderColor: Color {
        switch self {
        case .default, .readonly: Color.lightGreen
        case .error: Color.error
        }
    }

    var backgroundColor: Color {
        switch self {
        case .default, .error: Color.clear
        case .readonly: Color.surfaceDim
        }
    }
}

// MARK: - Constants
private enum Metrics
{
    static let contentSpacing: CGFloat = 7
    static let contentPadding: CGFloat = 11
    static let textFieldPadding: CGFloat = 11
    static let hStackSpacing: CGFloat = 2

    static let borderWidth: CGFloat = 2
    static let cornerRadius: CGFloat = 8
    static let errorFontSize: CGFloat = 12
}

// MARK: - Color Extensions
extension Color
{
    static let surfaceContainer = Color.gray.opacity(0.3)
    static let surfaceDim = Color.gray.opacity(0.1)
    static let error = Color.red
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        // Email field
        CustomTextField(
            fieldType: .email,
            text: .constant("")
        )

        // Email field with error
        CustomTextField(
            fieldType: .email,
            text: .constant("invalid-email"),
            error: "Error"
        )

        // Password field
        CustomTextField(
            fieldType: .password,
            text: .constant("fwefwe")
        )

        // Name field
        CustomTextField(
            fieldType: .name,
            text: .constant("")
        )

        // Phone number field
        CustomTextField(
            fieldType: .phoneNumber,
            text: .constant("")
        )

        // Optional text field
        CustomTextField(
            fieldType: .text,
            text: .constant("")
        )
    }
    .padding()
}
