//
//  ProgressOverlayPosition.swift
//  ToastUI
//
//  Created by Pardip Bhatti
//

import SwiftUI

/// Position options for progress overlay
public enum ProgressOverlayPosition: Sendable, Equatable {
    case top
    case center
    case bottom
    case custom(x: CGFloat, y: CGFloat)
}
