// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public extension Note {
    func name(for displayMode: NoteDisplayMode) -> String {
        guard self.note.isSharp else {
            return self.name
        }

        switch displayMode {
        case .both:
            return "\(self.note.name)\(self.octave) / \(self.note.nameWithFlats)\(self.octave)"
        case .flats, .sharps:
            return "\(self.note.name(for: displayMode))\(self.octave)"
        }
    }
}
