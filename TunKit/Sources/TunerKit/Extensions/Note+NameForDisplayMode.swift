// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public extension Note {
    func name(for displayMode: NoteDisplayMode) -> String {
        guard self.semitone.isSharp else {
            return self.name
        }

        switch displayMode {
        case .both:
            return "\(self.semitone.name)\(self.octave.rawValue) / \(self.semitone.nameWithFlats)\(self.octave.rawValue)"
        case .flats, .sharps:
            return "\(self.semitone.name(for: displayMode))\(self.octave.rawValue)"
        }
    }
}
