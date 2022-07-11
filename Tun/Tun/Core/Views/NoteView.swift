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

        return .theme.closestTunerBackgroundColor
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
        Image(systemName: "zzz")
            .opacity(0.35)
    }
    
    init(
        note: Note? = nil,
        isListening: Bool = false,
        displayMode: Binding<NoteDisplayMode> = .constant(.both)
    ) {
        self.note = note
        self.isListening = isListening
        self._displayMode = displayMode
    }
}

// MARK: - Extensions

private extension Note {
    func attributedName(
        for displayMode: NoteDisplayMode,
        fontSize: CGFloat
    ) -> AttributedString {
        let nameWithSharps = AttributedString(self.semitone.name(for: .sharps))

        var octaveAttributes = AttributeContainer()
        octaveAttributes.font = Font.system(size: fontSize * 0.65)
        octaveAttributes.baselineOffset = fontSize * -0.25
        let octave = AttributedString("\(self.octave.rawValue)", attributes: octaveAttributes)

        guard self.semitone.isSharp else {
            return nameWithSharps + octave
        }

        let nameWithFlats = AttributedString(self.semitone.name(for: .flats))

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
        Group {
            NoteView(
                note: .c(2),
                isListening: true
            )
            
            ForEach(NoteDisplayMode.allCases, id: \.self) { displayMode in
                NoteView(
                    note: .cSharp(4),
                    isListening: true,
                    displayMode: .constant(displayMode)
                )
            }
        }
        .previewMatrix(.sizeThatFits, colorSchemes: [.light])
    }
}
