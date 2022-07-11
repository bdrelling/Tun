// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public extension TunerData {
    static func mocked(
        frequency: Float? = nil,
        amplitude: Float = 0.5,
        note: Note = .standard
    ) -> Self {
        .init(
            frequency: note.frequency,
            amplitude: amplitude,
            note: note
        )
    }
    
    static func mocked(
        _ note: Note
    ) -> Self {
        .mocked(
            note: note
        )
    }
    
    static func mocked(
        frequency: Float
    ) -> Self {
        .mocked(
            frequency: frequency,
            note: MusicMath.noteForFrequency(frequency)
        )
    }
}
