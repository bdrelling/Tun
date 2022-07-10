// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import MusicKit

public extension TunerData {
    func noteName(for displayMode: NoteDisplayMode) -> String {
        self.note?.name(for: displayMode) ?? Note.inactiveNoteSymbol
    }
}
