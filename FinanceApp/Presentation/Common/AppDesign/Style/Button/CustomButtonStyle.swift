//
//  CustomButtonStyle.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 07.11.2025.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle
{
    let font: Font
    let width: CGFloat
    let height: CGFloat
    let borderRadius: CGFloat
    let activeColor: Color
    let colorText: Color
    let colorStroke: Color
    let isLoading: Bool

    @Environment(\.isEnabled) var isEnabled: Bool

    init(
        font: Font,
        width: CGFloat,
        height: CGFloat,
        borderRadius: CGFloat = 20,
        activeColor: Color,
        colorText: Color = .primary,
        colorStroke: Color = .clear,
        isLoading: Bool = false
    ) {
        self.font = font
        self.width = width
        self.height = height
        self.borderRadius = borderRadius
        self.activeColor = activeColor
        self.colorText = colorText
        self.colorStroke = colorStroke
        self.isLoading = isLoading
    }

    func makeBody(configuration: Configuration) -> some View {
        self.scence(isLoading: isLoading, configuration: configuration)
            .font(self.font)
            .frame(maxWidth: .infinity)
            .frame(height: self.height)
            .foregroundStyle(self.colorText)
            .background(self.isEnabled ? self.activeColor : Color(.colorSecondary))
            .clipShape(.rect(cornerRadius: borderRadius))
            .opacity(configuration.isPressed ? Constants.opacityPressed : Constants.opacity)
            .scaleEffect(configuration.isPressed ? Constants.scaleEffectPressed : Constants.scaleEffect)
            .overlay {
                RoundedRectangle(cornerRadius: borderRadius)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(colorStroke)
            }
            .padding()
    }
}

private extension CustomButtonStyle
{
    @ViewBuilder
    func scence(isLoading: Bool, configuration: Configuration) -> some View {
        if isLoading {
            ProgressView()
        } else {
            configuration.label
        }
    }
}

private extension CustomButtonStyle
{
    enum Constants
    {
        static let scaleEffect: CGFloat = 1
        static let scaleEffectPressed: CGFloat = 0.98

        static let opacity: CGFloat = 1
        static let opacityPressed: CGFloat = 0.7
    }
}

extension View
{
    func mainAuthButtonStyle(isLoading: Bool = false) -> some View {
        self.buttonStyle(
            CustomButtonStyle(
                font: .semibold20,
                width: 207,
                height: 45,
                activeColor: .caribbeanGreen,
                isLoading: isLoading
            )
        )
    }

    func secondaryAuthButtonStyle() -> some View {
        self.buttonStyle(CustomButtonStyle(font: .semibold20, width: 207, height: 45, activeColor: .lightGreen))
    }

    func operationButtonStyle(activeColor: Color, colorText: Color) -> some View {
        self.buttonStyle(
            CustomButtonStyle(
                font: .title,
                width: CGFloat.infinity,
                height: 101,
                borderRadius: 10,
                activeColor: activeColor,
                colorText: colorText,
                colorStroke: .clear
            )
        )
    }
}

#Preview(body: {
    Button {} label: {
        Text("dewdvsvsdvsde")
    }.mainAuthButtonStyle(isLoading: false)
})
