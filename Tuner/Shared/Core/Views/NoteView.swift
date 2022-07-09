// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import MusicKit
import SwiftUI
import TunerKit

struct NoteView: View {
    private static let fontSize: CGFloat = 96

    let note: Note?
    @Binding var isListening: Bool
    @Binding var displayMode: NoteDisplayMode

//    private var note: Note? {
//        self.data.note
//    }

    private var backgroundColor: Color {
        guard self.isListening else {
            return .inactive
        }

        return .closer
    }

    var body: some View {
        Group {
            if let note = self.note {
                Text(note.name(for: self.displayMode))
                    .fontWeight(.bold)
            } else {
                Text(Note.inactiveNoteSymbol)
                    .fontWeight(.bold)
            }
        }
        .font(.system(size: Self.fontSize))
        .foregroundColor(.white)
        .minimumScaleFactor(0.25)
        .lineLimit(1)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(self.backgroundColor)
    }
}

extension Note {
    var textView: some View {
        Text(self.note.name)
            + Text("\(self.octave)")
            .font(.system(size: 8.0))
            .baselineOffset(6.0)
    }
}

// MARK: - Previews

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(NoteDisplayMode.allCases, id: \.self) { displayMode in
            ForEach([true, false], id: \.self) { isListening in
                NoteView(
                    note: .standard,
                    isListening: .constant(isListening),
                    displayMode: .constant(displayMode)
                )
            }
        }
        .previewMatrix(.sizeThatFits, colorSchemes: [.light])
    }
}
