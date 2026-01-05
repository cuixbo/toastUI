//
//  ProgressOverlayMessage.swift
//  ToastUI
//
//  Created by Pardip Bhatti
//

import SwiftUI

/// Message model for progress overlay
public struct ProgressOverlayMessage: Identifiable, Equatable {
    public let id = UUID()
    public let title: String?
    public let message: String?
    public let position: ProgressOverlayPosition
    public let configuration: ProgressOverlayConfiguration
    public let customView: AnyView?
    public let dismissible: Bool
    public let onDismiss: (() -> Void)?

    public init(
        title: String? = nil,
        message: String? = nil,
        position: ProgressOverlayPosition = .center,
        configuration: ProgressOverlayConfiguration = .default,
        customView: AnyView? = nil,
        dismissible: Bool = false,
        onDismiss: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.position = position
        self.configuration = configuration
        self.customView = customView
        self.dismissible = dismissible
        self.onDismiss = onDismiss
    }

    public static func == (lhs: ProgressOverlayMessage, rhs: ProgressOverlayMessage) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Convenience Initializers with Custom View
public extension ProgressOverlayMessage {
    init<Content: View>(
        title: String? = nil,
        message: String? = nil,
        position: ProgressOverlayPosition = .center,
        configuration: ProgressOverlayConfiguration = .default,
        dismissible: Bool = false,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder customView: () -> Content
    ) {
        self.init(
            title: title,
            message: message,
            position: position,
            configuration: configuration,
            customView: AnyView(customView()),
            dismissible: dismissible,
            onDismiss: onDismiss
        )
    }
}
