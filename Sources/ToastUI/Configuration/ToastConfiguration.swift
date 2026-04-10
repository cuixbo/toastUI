//
//  File.swift
//  ToastUI
//
//  Created by Pardip Bhatti on 21/12/25.
//

import SwiftUI

public struct ToastConfiguration : Sendable {
    public enum HorizontalAlignment: String, Sendable {
        case leading
        case center
        case trailing
    }

    public let cornerRadius: CGFloat
    public let shadowRadius: CGFloat
    public let shadowColor: Color
    public let shadowX: CGFloat
    public let shadowY: CGFloat
    public let titleStyle: ToastTextStyle
    public let messageStyle: ToastTextStyle
    public let horizontalPadding: CGFloat
    public let verticalPadding: CGFloat
    public let horizontalMargin: CGFloat
    public let horizontalAlignment: HorizontalAlignment
    public let iconSpacing: CGFloat
    public let titleMessageSpacing: CGFloat
    public let showIcon: Bool
    public let useGradientBackground: Bool
    public let isCapsule: Bool
    public let isWidthAdaptive: Bool
    
    public init(
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 10,
        shadowColor: Color = .black.opacity(0.2),
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 5,
        titleStyle: ToastTextStyle = .defaultTitle,
        messageStyle: ToastTextStyle = .defaultMessage,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 16,
        horizontalMargin: CGFloat = 16,
        horizontalAlignment: HorizontalAlignment = .leading,
        iconSpacing: CGFloat = 12,
        titleMessageSpacing: CGFloat = 4,
        showIcon: Bool = true,
        useGradientBackground: Bool = true,
        isCapsule: Bool = false,
        isWidthAdaptive: Bool = false
    ) {
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.shadowX = shadowX
        self.shadowY = shadowY
        self.titleStyle = titleStyle
        self.messageStyle = messageStyle
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.horizontalMargin = horizontalMargin
        self.horizontalAlignment = horizontalAlignment
        self.iconSpacing = iconSpacing
        self.titleMessageSpacing = titleMessageSpacing
        self.showIcon = showIcon
        self.useGradientBackground = useGradientBackground
        self.isCapsule = isCapsule
        self.isWidthAdaptive = isWidthAdaptive
    }
    
    public static let `default` = ToastConfiguration()
    
    public static let compact = ToastConfiguration(
        cornerRadius: 8,
        shadowRadius: 5,
        shadowY: 3,
        horizontalPadding: 12,
        verticalPadding: 12
    )
    
    public static let rounded = ToastConfiguration(
        cornerRadius: 20,
        shadowRadius: 15,
        shadowY: 8
    )
    
    public static let minimal = ToastConfiguration(
        cornerRadius: 6,
        shadowRadius: 3,
        shadowY: 2,
        horizontalPadding: 12,
        verticalPadding: 10
    )

    public static let nonGradient = ToastConfiguration(
        cornerRadius: 12,
        shadowRadius: 10,
        shadowColor: .black.opacity(0.2),
        shadowX: 0,
        shadowY: 5,
        horizontalPadding: 16,
        verticalPadding: 16,
        showIcon: true,
        useGradientBackground: false
    )

    public static let noIcon = ToastConfiguration(
        cornerRadius: 12,
        shadowRadius: 10,
        shadowColor: .black.opacity(0.2),
        shadowX: 0,
        shadowY: 5,
        horizontalPadding: 16,
        verticalPadding: 16,
        showIcon: false,
        useGradientBackground: true
    )

    public static let capsule = ToastConfiguration(
        isCapsule: true
    )
    
    public static let autoWidth = ToastConfiguration(
        showIcon: true,
        useGradientBackground: true,
        isWidthAdaptive: true
    )
}
