// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public struct Tuning: Equatable {
    public let name: String
    public let notes: [Note]

    public init(_ name: String, notes: Note...) {
        self.init(name, notes: notes)
    }

    public init(_ name: String, notes: [Note]) {
        self.name = name
        self.notes = notes
    }
}

// MARK: - Extensions

extension Tuning {
    func closestNote(to frequency: Float) -> Note? {
        self.notes.closest(to: frequency)
    }
}
