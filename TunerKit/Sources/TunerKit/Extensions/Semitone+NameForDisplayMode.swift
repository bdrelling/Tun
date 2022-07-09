// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public extension Semitone {
    func name(for displayMode: NoteDisplayMode) -> String {
        switch displayMode {
        case .both:
            return "\(self.name) / \(self.nameWithFlats)"
        case .flats:
            return self.nameWithFlats
        case .sharps:
            return self.name
        }
    }
}
