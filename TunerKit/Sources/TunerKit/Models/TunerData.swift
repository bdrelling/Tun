// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public struct TunerData {
    public let frequency: Float
    public let amplitude: Float
    public let note: Note?

    var noteName: String {
        self.note?.name ?? Note.inactiveNoteSymbol
    }

    public init(
        frequency: Float,
        amplitude: Float,
        note: Note? = nil
    ) {
        self.frequency = frequency
        self.amplitude = amplitude
        self.note = note
    }
}

// MARK: - Convenience

public extension TunerData {
    static let inactive: Self = .init(
        frequency: 0,
        amplitude: 0
    )
}
