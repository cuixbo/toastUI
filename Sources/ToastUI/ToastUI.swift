//
//  ToastView.swift
//  ToastPackage
//


import SwiftUI

struct ToastView: View {
    let toast: ToastMessage
    let containerWidth: CGFloat
    let onDismiss: () -> Void
    @State private var showCopiedFeedback = false

    private var effectiveBackgroundColor: Color {
        toast.backgroundColor ?? toast.type.color
    }

    private var backgroundFill: AnyShapeStyle {
        if toast.configuration.useGradientBackground {
            return AnyShapeStyle(effectiveBackgroundColor.gradient)
        }
        return AnyShapeStyle(effectiveBackgroundColor)
    }
    
    private var shouldShowIcon: Bool {
        toast.configuration.showIcon
    }

    private var supportsGlassEffect: Bool {
        if #available(iOS 26.0, macOS 15.0, *) {
            return true
        }
        return false
    }
    
    private var isWidthAdaptive: Bool {
        toast.configuration.isWidthAdaptive
    }

    private var iconSpacing: CGFloat {
        toast.configuration.iconSpacing
    }

    private var titleMessageSpacing: CGFloat {
        toast.configuration.titleMessageSpacing
    }
    
    private var toastShape: ToastContainerShape {
        ToastContainerShape(
            isCapsule: toast.configuration.isCapsule,
            cornerRadius: toast.configuration.cornerRadius
        )
    }

    private var frameAlignment: Alignment {
        switch toast.configuration.horizontalAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }

    private func toastContainer<Content: View>(
        @ViewBuilder _ content: () -> Content,
        fillStyle: AnyShapeStyle,
        borderOpacity: Double = 0,
        borderColor: Color = .white
    ) -> some View {
        content()
            .padding(.horizontal, toast.configuration.horizontalPadding)
            .padding(.vertical, toast.configuration.verticalPadding)
            .background(
                toastShape
                    .fill(fillStyle)
                    .shadow(
                        color: toast.configuration.shadowColor,
                        radius: toast.configuration.shadowRadius,
                        x: toast.configuration.shadowX,
                        y: toast.configuration.shadowY
                    )
            )
            .overlay(
                toastShape
                    .stroke(borderColor.opacity(borderOpacity), lineWidth: borderOpacity > 0 ? 1 : 0)
            )
            .fixedSize(horizontal: false, vertical: false)
            .frame(
                maxWidth: isWidthAdaptive ? containerWidth : .infinity,
                alignment: frameAlignment
            )
            .padding(.horizontal, isWidthAdaptive ? 0 : toast.configuration.horizontalMargin)
    }
    
    var body: some View {
        if toast.type == .progress {
            progressView
        } else if toast.type == .glass {
            if supportsGlassEffect {
                if #available(iOS 26.0, *) {
                    glassView
                } else {
                    fallbackGlassView
                }
            } else {
                fallbackGlassView
            }
        } else {
            standardView
        }
    }
    
    // MARK: - Progress View
    private var progressView: some View {
        toastContainer({
            HStack(spacing: 12) {
                ProgressView()
                    .tint(.white)
                
                Text(toast.title)
                    .toastStyled(toast.titleStyle)
                
                if !isWidthAdaptive {
                    Spacer()
                }
            }
        }, fillStyle: backgroundFill)
    }
    
    // MARK: - Standard View
    private var standardView: some View {
        toastContainer({
            HStack(spacing: iconSpacing) {
                // Icon
                if shouldShowIcon, let customIcon = toast.customIcon {
                    customIcon
                        .frame(width: 24, height: 24)
                } else if shouldShowIcon {
                    Image(systemName: toast.type.defaultIcon)
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                
                // Content
                VStack(alignment: .leading, spacing: titleMessageSpacing) {
                    Text(toast.title)
                        .toastStyled(toast.titleStyle)
                    
                    if let message = toast.message {
                        Text(message)
                            .toastStyled(toast.messageStyle)
                    }
                }
                
                if !isWidthAdaptive {
                    Spacer()
                }
                
                // Action buttons
                HStack(spacing: 12) {
                    // Copy button
                    if toast.enableCopy {
                        Button(action: copyToClipboard) {
                            ZStack {
                                Image(systemName: "doc.on.doc")
                                    .opacity(showCopiedFeedback ? 0 : 1)
                                
                                Image(systemName: "checkmark")
                                    .opacity(showCopiedFeedback ? 1 : 0)
                            }
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                            .animation(.spring(duration: 0.3), value: showCopiedFeedback)
                        }
                    }
                    
                    // Close button
                    if toast.showCloseButton {
                        Button(action: onDismiss) {
                            Image(systemName: "xmark")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                    }
                }
            }
        }, fillStyle: backgroundFill)
    }
    
    // MARK: - Glass Effect View (iOS 26+)
    @available(iOS 26.0, *)
    private var glassView: some View {
        toastContainer({
            HStack(spacing: iconSpacing) {
                // Icon
                if shouldShowIcon, let customIcon = toast.customIcon {
                    customIcon
                        .frame(width: 24, height: 24)
                } else if shouldShowIcon {
                    Image(systemName: toast.type.defaultIcon)
                        .font(.title2)
                        .foregroundStyle(.primary)
                }

                // Content
                VStack(alignment: .leading, spacing: titleMessageSpacing) {
                    Text(toast.title)
                        .toastStyled(toast.titleStyle)

                    if let message = toast.message {
                        Text(message)
                            .toastStyled(toast.messageStyle)
                    }
                }

                if !isWidthAdaptive {
                    Spacer()
                }

                // Action buttons
                HStack(spacing: 12) {
                    // Copy button
                    if toast.enableCopy {
                        Button(action: copyToClipboard) {
                            ZStack {
                                Image(systemName: "doc.on.doc")
                                    .opacity(showCopiedFeedback ? 0 : 1)
                                
                                Image(systemName: "checkmark")
                                    .opacity(showCopiedFeedback ? 1 : 0)
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .animation(.spring(duration: 0.3), value: showCopiedFeedback)
                        }
                    }

                    // Close button
                    if toast.showCloseButton {
                        Button(action: onDismiss) {
                            Image(systemName: "xmark")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }, fillStyle: AnyShapeStyle(.ultraThinMaterial), borderOpacity: 0.2)
    }

    // MARK: - Fallback Glass View (iOS < 26)
    private var fallbackGlassView: some View {
        toastContainer({
            HStack(spacing: iconSpacing) {
                // Icon
                if shouldShowIcon, let customIcon = toast.customIcon {
                    customIcon
                        .frame(width: 24, height: 24)
                } else if shouldShowIcon {
                    Image(systemName: toast.type.defaultIcon)
                        .font(.title2)
                        .foregroundStyle(.primary)
                }

                // Content
                VStack(alignment: .leading, spacing: titleMessageSpacing) {
                    Text(toast.title)
                        .toastStyled(toast.titleStyle)

                    if let message = toast.message {
                        Text(message)
                            .toastStyled(toast.messageStyle)
                    }
                }

                if !isWidthAdaptive {
                    Spacer()
                }

                // Action buttons
                HStack(spacing: 12) {
                    // Copy button
                    if toast.enableCopy {
                        Button(action: copyToClipboard) {
                            ZStack {
                                Image(systemName: "doc.on.doc")
                                    .opacity(showCopiedFeedback ? 0 : 1)
                                
                                Image(systemName: "checkmark")
                                    .opacity(showCopiedFeedback ? 1 : 0)
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .animation(.spring(duration: 0.3), value: showCopiedFeedback)
                        }
                    }

                    // Close button
                    if toast.showCloseButton {
                        Button(action: onDismiss) {
                            Image(systemName: "xmark")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }, fillStyle: AnyShapeStyle(.regularMaterial), borderOpacity: 0.1)
    }

    // MARK: - Copy Function

    private func copyToClipboard() {
        #if os(iOS)
        UIPasteboard.general.string = toast.copyableText
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(toast.copyableText, forType: .string)
        #endif

        // Show feedback
        withAnimation(.spring(duration: 0.3)) {
            showCopiedFeedback = true
        }

        // Reset after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.spring(duration: 0.3)) {
            showCopiedFeedback = false
            }
        }
    }
}

private struct ToastContainerShape: Shape {
    let isCapsule: Bool
    let cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        if isCapsule {
            return Capsule().path(in: rect)
        }
        return RoundedRectangle(cornerRadius: cornerRadius).path(in: rect)
    }
}

private extension Text {
    func toastStyled(_ style: ToastTextStyle) -> some View {
        self
            .font(style.resolvedFont)
            .foregroundStyle(style.color)
            .lineSpacing(style.lineSpacing)
            .multilineTextAlignment(style.textAlignment)
            .lineLimit(style.lineLimit)
            .truncationMode(style.truncationMode)
    }
}
