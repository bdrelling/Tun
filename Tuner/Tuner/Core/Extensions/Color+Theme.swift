// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

extension Color {
    static let theme: Theme = .default
}

// MARK: - Supporting Types

extension Color {
    struct Theme {
        let backgroundColor: Color

        let inactiveTunerBackgroundColor: Color = .init("InactiveTunerBackground")
        let closestTunerBackgroundColor: Color = .init("ClosestTunerBackground")
        let closerTunerBackgroundColor: Color = .init("CloserTunerBackground")
        let farTunerBackgroundColor: Color = .init("FarTunerBackground")
        let otherTunerBackgroundColor: Color = .init("OtherTunerBackground")
    }
}

private extension Color {
    #if canImport(UIKit)
        static let universalSystemBackground: Color = .init(UIColor.systemBackground)
    #elseif canImport(AppKit)
        static let universalSystemBackground: Color = .init(NSColor.textBackgroundColor)
    #endif
}

// MARK: - Convenience

extension Color.Theme {
    static let `default`: Self = .init(
        backgroundColor: .universalSystemBackground
    )
}
