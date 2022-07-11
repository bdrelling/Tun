// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

extension Color {
    static let theme: Theme = .default
}

// MARK: - Supporting Types

extension Color {
    struct Theme {
        let backgroundColor: Color
        let cellBackgroundColor: Color

        let inactiveTunerBackgroundColor: Color
        let closestTunerBackgroundColor: Color
        let closerTunerBackgroundColor: Color
        let farTunerBackgroundColor: Color
        let otherTunerBackgroundColor: Color
    }
}

// MARK: - Convenience

extension Color.Theme {
    static let `default`: Self = .init(
        backgroundColor: .init(UIColor.systemBackground),
        cellBackgroundColor: .init(UIColor.secondarySystemFill),
        inactiveTunerBackgroundColor: .init("InactiveTunerBackground"),
        closestTunerBackgroundColor: .init("ClosestTunerBackground"),
        closerTunerBackgroundColor: .init("CloserTunerBackground"),
        farTunerBackgroundColor: .init("FarTunerBackground"),
        otherTunerBackgroundColor: .init("OtherTunerBackground")
    )
}
