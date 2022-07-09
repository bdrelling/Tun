// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public struct Tuning {
    public let instrument: Instrument
    public let notes: [Note]

    public init(_ instrument: Instrument, notes: Note...) {
        self.instrument = instrument
        self.notes = notes
    }
}

// MARK: - Convenience

public extension Tuning {
    static let standard: Self = .init(.guitar, notes: .e(2), .a(2), .d(3), .g(3), .b(3), .e(4))
}
