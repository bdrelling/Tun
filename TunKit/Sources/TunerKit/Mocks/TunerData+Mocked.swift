// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public extension TunerData {
    static let mocked: Self = .init(
        frequency: Note.standard.frequency,
        amplitude: 0.2,
        note: .standard
    )
}
