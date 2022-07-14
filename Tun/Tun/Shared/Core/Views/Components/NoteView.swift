// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import MusicKit
import SwiftUI
import TunerKit

struct NoteView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    private static let fontSize: CGFloat = 96

    let detectedNote: Note?
    let displayMode: NoteDisplayMode
    
    let selectedNote: Note?
    let isDetectingAudio: Bool
    
    private var backgroundColor: Color {
        // If the tuner isn't actively detecting audio, show the inactive background.
        guard self.isDetectingAudio else {
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
        guard let centsFromSelectedNote = self.centsFromSelectedNote else {
            return .theme.inactiveTunerBackgroundColor
        }
        
        if abs(centsFromSelectedNote) < self.appSettings.audio.centAccuracyThreshold {
            return .theme.closestTunerBackgroundColor
        } else {
            return .theme.closerTunerBackgroundColor
        }
    }
    
    private var centsFromSelectedNote: Float? {
        guard let detectedNote = self.detectedNote, let selectedNote = self.selectedNote else {
            return nil
        }
        
        return MusicMath.cents(from: detectedNote, to: selectedNote)
    }

    var body: some View {
        Group {
            VStack {
                if let note = self.detectedNote {
                    Text(note.attributedName(for: self.displayMode, fontSize: Self.fontSize))
                } else {
                    self.inactiveTextView
                }
                
                if let centsFromSelectedNote = self.centsFromSelectedNote {
                    Text("\(centsFromSelectedNote, specifier: "%.2f") cents")
                        .font(.body)
                        .opacity(self.isDetectingAudio ? 0.65 : 0.35)
                        .padding(.top, 48)
                }
            }
        }
        .font(.system(size: Self.fontSize))
        .foregroundColor(.white)
        .minimumScaleFactor(0.25)
        .lineLimit(1)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            self.backgroundColor
                .animation(.linear, value: self.detectedNote)
                .animation(.easeInOut, value: self.isDetectingAudio)
        )
    }

    private var inactiveTextView: some View {
        Image(systemName: "zzz")
            .opacity(0.35)
    }
    
    init(
        detectedNote: Note? = nil,
        selectedNote: Note? = nil,
        isDetectingAudio: Bool = false,
        displayMode: NoteDisplayMode = .both
    ) {
        self.detectedNote = detectedNote
        self.isDetectingAudio = isDetectingAudio
        self.selectedNote = selectedNote
        self.displayMode = displayMode
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
                isDetectingAudio: true
            )
            
            ForEach(NoteDisplayMode.allCases, id: \.self) { displayMode in
                NoteView(
                    detectedNote: .cSharp(4),
                    isDetectingAudio: true,
                    displayMode: displayMode
                )
            }
        }
        .environmentObject(AppSettings.mocked)
        .previewMatrix(.sizeThatFits, colorSchemes: [.light])
    }
}
