// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import MusicKit
import SwiftUI
import TunerKit

struct NoteView: View {
    private static let fontSize: CGFloat = 96

    let note: Note?
    let isListening: Bool

    @Binding var displayMode: NoteDisplayMode

    private var backgroundColor: Color {
        guard self.isListening else {
            return .theme.inactiveTunerBackgroundColor
        }

        return .theme.closerTunerBackgroundColor
    }

    var body: some View {
        Group {
            if let note = self.note {
                Text(note.attributedName(for: self.displayMode, fontSize: Self.fontSize))
            } else {
                self.inactiveTextView
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

    private var inactiveTextView: some View {
        Text(Note.inactiveNoteSymbol)
            .fontWeight(.bold)
            .opacity(0.65)
    }
}

// MARK: - Extensions

private extension Note {
    func attributedName(
        for displayMode: NoteDisplayMode,
        fontSize: CGFloat
    ) -> AttributedString {
        guard self.semitone.isSharp else {
            return .init(self.name)
        }

        let nameWithSharps = AttributedString(self.semitone.name(for: .sharps))
        let nameWithFlats = AttributedString(self.semitone.name(for: .flats))

        var octaveAttributes = AttributeContainer()
        octaveAttributes.font = Font.system(size: fontSize * 0.65)
        octaveAttributes.baselineOffset = fontSize * -0.25

        let octave = AttributedString("\(self.octave)", attributes: octaveAttributes)
        let divider = AttributedString(" / ")

        switch displayMode {
        case .sharps:
            return nameWithSharps + octave
        case .flats:
            return nameWithFlats + octave
        case .both:
            return nameWithSharps + octave + divider + nameWithFlats + octave
        }
    }
}

// MARK: - Previews

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(NoteDisplayMode.allCases, id: \.self) { displayMode in
            ForEach([true, false], id: \.self) { isListening in
                NoteView(
                    note: .cSharp(4),
                    isListening: isListening,
                    displayMode: .constant(displayMode)
                )
            }
        }
        .previewMatrix(.sizeThatFits, colorSchemes: [.light])
    }
}
