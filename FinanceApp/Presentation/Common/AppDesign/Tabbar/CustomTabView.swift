//
//  CustomTabView.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 19.12.2025.
//

import SwiftUI

struct CustomTabView<
    Content: View,
    Value: CaseIterable & Hashable & RawRepresentable
>: View where Value.AllCases: Hashable & RandomAccessCollection, Value.RawValue == String
{
    @Binding var selection: Value
    var content: (Value, CGFloat) -> Content
    var config: CustomTabViewConfig

    init(
        config: CustomTabViewConfig = .init(),
        selection: Binding<Value>,
        @ViewBuilder content: @escaping (
            Value,
            CGFloat
        ) -> Content
    ) {
        self.config = config
        self._selection = selection
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection) {
                ForEach(Value.allCases, id: \.hashValue) { tab in
                    content(tab, 0)
                        .tag(tab)
                }
            }
            CustomTabbar(config: config, activeTab: $selection)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct CustomTabViewConfig
{
    var activeTint: Color = .white
    var activeBackgroundTint: Color = .caribbeanGreen
    var inactiveTint: Color = .gray
    var tabAnimation: Animation = .smooth(duration: 0.35, extraBounce: 0)
    var backgroundColor: Color = .gray.opacity(0.1)
    var insetAmount: CGFloat = 12
    var isTransluckent: Bool = true
}

private struct CustomTabbar<
    Value: CaseIterable & Hashable & RawRepresentable
>: View where Value.AllCases: Hashable & RandomAccessCollection, Value.RawValue == String
{
    var config: CustomTabViewConfig
    @Binding var activeTab: Value
    @Namespace private var animation
    @State private var toggleSymbolEffect: [Bool] = Array(repeating: false, count: Value.allCases.count)
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Value.allCases, id: \.hashValue) { tab in
                let isActive = activeTab == tab
                let index = (Value.allCases.firstIndex(of: tab) as? Int) ?? 0
                Image(colorScheme == .dark && activeTab != tab ? tab.rawValue + "Dark" : tab.rawValue)
                    .foregroundStyle(.primary)
                    .applySymbolEffect(value: toggleSymbolEffect[index])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                    .background {
                        if isActive {
                            Circle()
                                .fill(config.activeBackgroundTint)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .onTapGesture {
                        activeTab = tab
                        toggleSymbolEffect[index].toggle()
                    }
                    .padding(.vertical, config.insetAmount)
            }
        }
        .padding(.horizontal, config.insetAmount)
        .frame(height: 80)
        .background {
            ZStack {
                if config.isTransluckent {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                } else {
                    Rectangle()
                        .fill(.background)
                }
            }
        }
        .clipShape(.capsule(style: .continuous))
        .animation(config.tabAnimation, value: activeTab)
    }
}

extension CustomTabbar
{
    private func triggerEffect(for index: Int) {
        if #available(iOS 17.0, *) {
            toggleSymbolEffect[index].toggle()
        }
    }
}

extension View
{
    @ViewBuilder
    func applySymbolEffect(value: Bool) -> some View {
        if #available(iOS 17.0, *) {
            self.symbolEffect(.bounce.byLayer.down, value: value)
        } else {
            self
        }
    }

    func conditionalGradient(isActive: Bool) -> some View {
        Group {
            if #available(iOS 16.0, *) {
                self.background(
                    Capsule()
                        .fill(.blue.gradient)
                )
            } else {
                self.background(
                    Capsule()
                        .fill(.blue)
                )
            }
        }
    }
}
