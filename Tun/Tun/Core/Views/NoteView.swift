// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import MusicKit
import SwiftUI
import TunerKit

struct NoteView: View {
    private static let fontSize: CGFloat = 96

    let detectedNote: Note?
    let selectedNote: Note?
    let isListening: Bool

    @Binding var displayMode: NoteDisplayMode

    private var backgroundColor: Color {
        // If the tuner isn't actively detecting audio, show the inactive background.
        guard self.isListening else {
            return .theme.inactiveTunerBackgroundColor
        }
        
        // If the tuner has never detected audio, show the inactive background.
        guard let detectedNote = self.detectedNote else {
            return .theme.inactiveTunerBackgroundColor
        }

        // If no note is selected, show the accurate background to indicate audio detection.
        guard let selectedNote = self.selectedNote else {
            return .theme.closestTunerBackgroundColor
        }
        
        // If the note isn't registering as the same semitone and octave, show the inaccurate background.
        guard detectedNote.semitone == selectedNote.semitone, detectedNote.octave == selectedNote.octave else {
            return .theme.farTunerBackgroundColor
        }
        
        // If the distance between the detected and selected note
        #warning("A static value here doesn't make sense since frequency is exponential, I need to find out how accuracy should work here.")
        if abs(detectedNote.frequency - selectedNote.frequency) < 3 {
            return .theme.closestTunerBackgroundColor
        } else {
            return .theme.closerTunerBackgroundColor
        }
    }
    
    private var frequencyDelta: Float? {
        guard let detectedNote = self.detectedNote, let selectedNote = self.selectedNote else {
            return nil
        }
        
        #warning("For some reason this is always 0 or the difference between notes. Something is being truncated or rounded maybe? Need raw frequency.")
        return abs(detectedNote.frequency - selectedNote.frequency)
    }

    var body: some View {
        Group {
            VStack {
                if let note = self.detectedNote {
                    Text(note.attributedName(for: self.displayMode, fontSize: Self.fontSize))
                } else {
                    self.inactiveTextView
                }
                
                if let frequencyDelta = self.frequencyDelta {
                    Text("Delta: \(frequencyDelta) Hz")
                        .font(.caption)
                }
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
        detectedNote: Note? = nil,
        selectedNote: Note? = nil,
        isListening: Bool = false,
        displayMode: Binding<NoteDisplayMode> = .constant(.both)
    ) {
        self.detectedNote = detectedNote
        self.isListening = isListening
        self.selectedNote = selectedNote
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
                detectedNote: .c(2),
                isListening: true
            )
            
            ForEach(NoteDisplayMode.allCases, id: \.self) { displayMode in
                NoteView(
                    detectedNote: .cSharp(4),
                    isListening: true,
                    displayMode: .constant(displayMode)
                )
            }
        }
        .previewMatrix(.sizeThatFits, colorSchemes: [.light])
    }
}
