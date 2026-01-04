//
//  ScrollDetector.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 03.01.2026.
//

import SwiftUI
import UIKit

struct ScrollDetector: UIViewRepresentable
{
    var onScroll: (CGFloat) -> Void /// Offset, Velocity
    var onDraggingEnd: (CGFloat, CGFloat) -> Void /// Offset, Velocity

    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollview = uiView.superview?.superview?.superview as? UIScrollView,
                context.coordinator.isDelegateAdded == false {
                scrollview.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
        /// ScrollView Delegate Methods
    final class Coordinator: NSObject, UIScrollViewDelegate
    {
        var parent: ScrollDetector

        init(parent: ScrollDetector) {
            self.parent = parent
        }

        /// One time Delegate Initialization
        var isDelegateAdded: Bool = false

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }

        func scrollViewWillEndDragging(
            _ scrollView: UIScrollView,
            withVelocity velocity: CGPoint,
            targetContentOffset: UnsafeMutablePointer<CGPoint>
        ) {
            parent.onDraggingEnd(targetContentOffset.pointee.y, velocity.y)
        }
    }
}
