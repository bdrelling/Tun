// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public extension Note {
    func name(for displayMode: NoteDisplayMode) -> String {
        "\(self.note.name(for: displayMode))\(self.octave)"
    }
}
