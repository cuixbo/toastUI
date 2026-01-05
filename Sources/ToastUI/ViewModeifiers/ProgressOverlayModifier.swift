//
//  ProgressOverlayModifier.swift
//  ToastUI
//
//  Created by Pardip Bhatti
//

import SwiftUI

struct ProgressOverlayModifier: ViewModifier {
    @ObservedObject var manager: ToastManager

    func body(content: Content) -> some View {
        ZStack {
            content

            if let overlay = manager.progressOverlay {
                ZStack {
                    // Backdrop
                    if overlay.configuration.isBlocking {
                        Color.black
                            .opacity(overlay.configuration.backdropOpacity)
                            .ignoresSafeArea()
                            .onTapGesture {
                                // Block interactions when backdrop is visible
                            }
                    }

                    // Progress overlay
                    overlayContent(for: overlay)
                }
                .transition(.opacity)
                .zIndex(999)
            }
        }
    }

    @ViewBuilder
    private func overlayContent(for overlay: ProgressOverlayMessage) -> some View {
        GeometryReader { geometry in
            ProgressOverlayView(
                overlay: overlay,
                onDismiss: {
                    overlay.onDismiss?()
                }
            )
            .position(position(for: overlay.position, in: geometry.size))
        }
    }

    private func position(for position: ProgressOverlayPosition, in size: CGSize) -> CGPoint {
        switch position {
        case .top:
            return CGPoint(x: size.width / 2, y: size.height * 0.25)
        case .center:
            return CGPoint(x: size.width / 2, y: size.height / 2)
        case .bottom:
            return CGPoint(x: size.width / 2, y: size.height * 0.75)
        case .custom(let x, let y):
            return CGPoint(x: x, y: y)
        }
    }
}

public extension View {
    /// Adds progress overlay support to the view
    func progressOverlaySupport(manager: ToastManager = .shared) -> some View {
        self.modifier(ProgressOverlayModifier(manager: manager))
    }
}
