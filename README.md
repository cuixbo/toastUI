# ToastUI 🎉

A powerful notification system for SwiftUI with toasts and dialogs - built with modern Swift concurrency and environment-based API.

![Platform](https://img.shields.io/badge/platform-iOS%2016%2B%20%7C%20macOS%2013.1%2B-blue)
![Swift](https://img.shields.io/badge/Swift-6.2+-orange)
![License](https://img.shields.io/badge/license-MIT-green)

## Features ✨

### 🍞 Toast Notifications
- **Simple API** - Just `@Environment(\.toast) var toast`
- **6 Toast Types** - Success, Error, Warning, Info, Progress, Glass Effect
- **Glass Effect** - Beautiful translucent glass toast (iOS 26+, auto-fallback to regular material)
- **3 Alignments** - Top, Center, Bottom
- **Custom Icons** - Use any SwiftUI View as icon
- **Custom Colors** - Brand your toasts
- **Copy to Clipboard** - One-tap copy for errors
- **Multiple Toasts** - Stack with depth effect
- **Smart Auto-dismiss** - Proper timer management

### 💬 Dialog System
- **Custom Dialogs** - Build with SwiftUI views
- **Pre-built Components** - Alert, Confirmation
- **Smooth Animations** - Bouncy slide-up
- **Backdrop Control** - Tap to dismiss or require action

### 🚀 General
- **SwiftUI Native** - Pure SwiftUI
- **iOS 16+ & macOS 13.1+** - Cross-platform
- **Swift 6 Ready** - Modern concurrency
- **Environment-based** - Seamless integration

---

## Requirements

- iOS 16.0+ / macOS 13.1+
- Swift 6.2+
- Xcode 16.2+

---

## Installation

### Swift Package Manager

1. In Xcode: **File** → **Add Package Dependencies**
2. Enter: `https://github.com/debuging-life/ToastUI.git`
3. Select **Up to Next Major Version** with `3.2.0`

Or in `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/debuging-life/ToastUI.git", from: "3.2.0")
]
```

---

## Quick Start

### Setup (One-time)

Add `.setupToastUI()` to your root view:

```swift
import SwiftUI
import ToastUI

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .setupToastUI() // ✅ Add this
        }
    }
}
```

### Basic Toast Usage

```swift
import SwiftUI
import ToastUI

struct ContentView: View {
    @Environment(\.toast) var toast

    var body: some View {
        VStack(spacing: 20) {
            Button("Show Success") {
                toast.success("Operation completed!")
            }

            Button("Show Error") {
                toast.error("Something went wrong")
            }

            Button("Show Warning") {
                toast.warning("Please check your input")
            }
        }
    }
}
```

---

## 📖 Complete Guide

## Table of Contents

1. [Toast Notifications](#toast-notifications)
2. [Dialog System](#dialog-system)
3. [Advanced Features](#advanced-features)

---

## Toast Notifications

### Basic Toast Types

```swift
@Environment(\.toast) var toast

// Success
toast.success("Saved successfully!")

// Error
toast.error("Failed to save")

// Warning
toast.warning("Low battery")

// Info
toast.info("New update available")

// Glass effect (iOS 26+, auto-fallback)
toast.glass("Beautiful glass toast", alignment: .top)

// Progress (single, non-stacking)
toast.progress("Uploading...", alignment: .center)
```

### Toast with Message

```swift
toast.success(
    "Payment Complete",
    message: "Your order #12345 has been confirmed"
)
```

### Custom Alignment

```swift
toast.success("Top toast", alignment: .top)
toast.info("Center toast", alignment: .center)
toast.error("Bottom toast", alignment: .bottom)
```

### Custom Icon

```swift
toast.success("Custom icon") {
    Image(systemName: "star.fill")
        .font(.largeTitle)
        .foregroundStyle(.yellow)
}
```

### Custom Colors

```swift
toast.show(
    ToastMessage(
        type: .custom(
            backgroundColor: .purple,
            foregroundColor: .white,
            iconColor: .yellow
        ),
        title: "Custom Colors",
        alignment: .top
    )
)
```

### Copy to Clipboard

```swift
// Shows a copy button that copies the message
toast.error("Error: File not found", enableCopy: true)
```

---

## Dialog System

### Basic Dialog

```swift
@State private var showDialog = false

Button("Show Dialog") {
    showDialog = true
}
.dialog(isPresented: $showDialog) {
    VStack(spacing: 20) {
        Text("Custom Dialog")
            .font(.title)

        Text("This is a custom dialog")

        Button("Close") {
            showDialog = false
        }
    }
    .padding()
}
```

### Dialog Configuration

```swift
.dialog(
    config: DialogConfiguration(
        backgroundColor: .black.opacity(0.6),
        cornerRadius: 24,
        dismissOnBackgroundTap: true,
        animationDuration: 0.35
    ),
    isPresented: $showDialog
) {
    DialogContent()
}
```

---

## Advanced Features

---

## Platform Support

### iOS 26+ Glass Effect

On iOS 26+, the `.glass` style uses `.ultraThinMaterial` for a true glass effect.

### iOS 16-25 Fallback

On iOS 16-25, the `.glass` style automatically falls back to `.regularMaterial`.

### macOS Support

Full support on macOS 13.1+.

---

## API Reference

### Toast API

```swift
@Environment(\.toast) var toast

// Show methods
toast.show(_ message: ToastMessage)
toast.success(_ title: String, message: String? = nil, alignment: ToastAlignment = .top)
toast.error(_ title: String, message: String? = nil, alignment: ToastAlignment = .top, enableCopy: Bool = false)
toast.warning(_ title: String, message: String? = nil, alignment: ToastAlignment = .top)
toast.info(_ title: String, message: String? = nil, alignment: ToastAlignment = .top)
toast.glass(_ title: String, message: String? = nil, alignment: ToastAlignment = .top)
toast.progress(_ title: String, message: String? = nil, alignment: ToastAlignment = .center)

// Dismiss
toast.dismiss(id: UUID)
```


---

## Examples

Check out the included example file:
- `ToastUIExamplesView.swift` - Toast and Dialog examples

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## License

ToastUI is available under the MIT license. See the LICENSE file for more info.

---

## Credits

Created by [Pardip Bhatti](https://github.com/debuging-life)

---

## Support

If you find this package useful, please consider:
- ⭐️ Starring the repo
- 🐛 Reporting issues
- 💡 Suggesting new features
- 📖 Improving documentation

---

**Made with ❤️ for the SwiftUI community**
