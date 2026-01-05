//
//  ProgressOverlayView.swift
//  ToastUI
//
//  Created by Pardip Bhatti
//

import SwiftUI

struct ProgressOverlayView: View {
    let overlay: ProgressOverlayMessage
    let onDismiss: () -> Void

    private var supportsGlassEffect: Bool {
        if #available(iOS 26.0, macOS 15.0, *) {
            return true
        }
        return false
    }

    var body: some View {
        Group {
            if overlay.configuration.useGlassEffect && supportsGlassEffect {
                if #available(iOS 26.0, *) {
                    glassView
                } else {
                    fallbackGlassView
                }
            } else if overlay.configuration.clearBackground {
                clearView
            } else {
                standardView
            }
        }
        .frame(
            width: overlay.configuration.width,
            height: overlay.configuration.height
        )
        .frame(
            minWidth: overlay.configuration.width == nil ? overlay.configuration.minWidth : nil,
            minHeight: overlay.configuration.height == nil ? overlay.configuration.minHeight : nil
        )
    }

    // MARK: - Standard View
    private var standardView: some View {
        VStack(spacing: 16) {
            contentView
        }
        .padding(.horizontal, overlay.configuration.horizontalPadding)
        .padding(.vertical, overlay.configuration.verticalPadding)
        .background(
            RoundedRectangle(cornerRadius: overlay.configuration.cornerRadius)
                .fill(overlay.configuration.backgroundColor.opacity(overlay.configuration.backgroundOpacity))
                .shadow(
                    color: overlay.configuration.shadowColor,
                    radius: overlay.configuration.shadowRadius,
                    x: overlay.configuration.shadowX,
                    y: overlay.configuration.shadowY
                )
        )
    }

    // MARK: - Glass Effect View (iOS 26+)
    @available(iOS 26.0, *)
    private var glassView: some View {
        VStack(spacing: 16) {
            contentView
        }
        .padding(.horizontal, overlay.configuration.horizontalPadding)
        .padding(.vertical, overlay.configuration.verticalPadding)
        .background(
            RoundedRectangle(cornerRadius: overlay.configuration.cornerRadius)
                .fill(.ultraThinMaterial)
                .shadow(
                    color: overlay.configuration.shadowColor,
                    radius: overlay.configuration.shadowRadius,
                    x: overlay.configuration.shadowX,
                    y: overlay.configuration.shadowY
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: overlay.configuration.cornerRadius)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }

    // MARK: - Fallback Glass View (iOS < 26)
    private var fallbackGlassView: some View {
        VStack(spacing: 16) {
            contentView
        }
        .padding(.horizontal, overlay.configuration.horizontalPadding)
        .padding(.vertical, overlay.configuration.verticalPadding)
        .background(
            RoundedRectangle(cornerRadius: overlay.configuration.cornerRadius)
                .fill(.regularMaterial)
                .shadow(
                    color: overlay.configuration.shadowColor,
                    radius: overlay.configuration.shadowRadius,
                    x: overlay.configuration.shadowX,
                    y: overlay.configuration.shadowY
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: overlay.configuration.cornerRadius)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }

    // MARK: - Clear Background View
    private var clearView: some View {
        VStack(spacing: 16) {
            contentView
        }
        .padding(.horizontal, overlay.configuration.horizontalPadding)
        .padding(.vertical, overlay.configuration.verticalPadding)
    }

    // MARK: - Content View
    @ViewBuilder
    private var contentView: some View {
        if let customView = overlay.customView {
            // User provided custom view
            customView
        } else {
            // Default progress view with optional text
            VStack(spacing: 12) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                    .tint(textColor)

                if let title = overlay.title {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(textColor)
                        .multilineTextAlignment(.center)
                }

                if let message = overlay.message {
                    Text(message)
                        .font(.subheadline)
                        .foregroundStyle(textColor.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
            }
        }

        if overlay.dismissible {
            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(textColor.opacity(0.7))
            }
            .padding(.top, 8)
        }
    }

    private var textColor: Color {
        if overlay.configuration.useGlassEffect || overlay.configuration.clearBackground {
            return .primary
        } else {
            // Determine text color based on background brightness
            let backgroundColor = overlay.configuration.backgroundColor
            if backgroundColor == .black || backgroundColor == .blue || backgroundColor == .indigo || backgroundColor == .purple {
                return .white
            } else {
                return .primary
            }
        }
    }
}
