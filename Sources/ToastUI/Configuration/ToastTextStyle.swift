//
//  ToastTextStyle.swift
//  ToastUI
//

import SwiftUI

public struct ToastTextStyle: @unchecked Sendable {
    public let font: Font
    public let fontWeight: Font.Weight?
    public let color: Color
    public let lineSpacing: CGFloat
    public let lineLimit: Int?
    public let truncationMode: Text.TruncationMode
    public let textAlignment: TextAlignment

    public init(
        font: Font = .body,
        fontWeight: Font.Weight? = nil,
        color: Color = .white,
        lineSpacing: CGFloat = 0,
        lineLimit: Int? = nil,
        truncationMode: Text.TruncationMode = .tail,
        textAlignment: TextAlignment = .leading
    ) {
        self.font = font
        self.fontWeight = fontWeight
        self.color = color
        self.lineSpacing = lineSpacing
        self.lineLimit = lineLimit
        self.truncationMode = truncationMode
        self.textAlignment = textAlignment
    }

    public var resolvedFont: Font {
        guard let fontWeight else {
            return font
        }
        return font.weight(fontWeight)
    }

    public static var defaultTitle: ToastTextStyle {
        ToastTextStyle(
            font: .headline,
            color: .white,
            lineSpacing: 0,
            lineLimit: nil,
            truncationMode: .tail,
            textAlignment: .leading
        )
    }

    public static var defaultMessage: ToastTextStyle {
        ToastTextStyle(
            font: .subheadline,
            color: .white.opacity(0.9),
            lineSpacing: 0,
            lineLimit: 3,
            truncationMode: .tail,
            textAlignment: .leading
        )
    }

    public static var glassTitle: ToastTextStyle {
        ToastTextStyle(
            font: .headline,
            color: .primary,
            lineSpacing: 0,
            lineLimit: nil,
            truncationMode: .tail,
            textAlignment: .leading
        )
    }

    public static var glassMessage: ToastTextStyle {
        ToastTextStyle(
            font: .subheadline,
            color: .secondary,
            lineSpacing: 0,
            lineLimit: 3,
            truncationMode: .tail,
            textAlignment: .leading
        )
    }
}
