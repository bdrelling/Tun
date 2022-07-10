// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public extension Semitone {
    func name(for displayMode: NoteDisplayMode) -> String {
        guard self.isSharp else {
            return self.name
        }

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

extension Semitone {
    var nameWithFlats: String {
        switch self {
        case .cSharp:
            return "D♭"
        case .dSharp:
            return "E♭"
        case .fSharp:
            return "G♭"
        case .gSharp:
            return "A♭"
        case .aSharp:
            return "B♭"
        default:
            return self.name
        }
    }
}
