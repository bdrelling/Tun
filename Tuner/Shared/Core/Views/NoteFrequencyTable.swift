// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import MusicKit
import SwiftUI

struct NoteFrequencyTable: View {
    var body: some View {
        VStack {
            ForEach(Semitone.allCases) { semitone in
                HStack {
                    ForEach(Octave.allCases) { octave in
                        let note = Note(semitone, octave: octave.rawValue)
                        Text(note.name)
                    }
                }
            }
        }
    }
}

// MARK: - Previews

struct NoteFrequencyTable_Previews: PreviewProvider {
    static var previews: some View {
        NoteFrequencyTable()
            .previewMatrix(.sizeThatFits, colorSchemes: [.light])
    }
}
