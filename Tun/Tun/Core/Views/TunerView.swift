// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
import InstrumentKit
import MusicKit
import SwiftUI
import TunerKit

struct TunerView: View {
    @StateObject var tuner: Tuner

    @State var selectedNote: Note?
    @Binding var noteDisplayMode: NoteDisplayMode

    var body: some View {
        ZStack {
            VStack {
                ActiveNoteView(
                    selection: self.$selectedNote,
                    data: self.tuner.data
                )
                .padding(.vertical, 48)

//                ActiveTuningView(
//                    tuning: .constant(Instrument.guitar.standardTuning),
//                    data: self.tuner.data
//                )

                Spacer()
            }
            
            NoteView(
                detectedNote: self.tuner.data.note,
                selectedNote: self.selectedNote,
                isListening: self.tuner.isListening,
                displayMode: self.$noteDisplayMode
            )
            .edgesIgnoringSafeArea(.all)
            .zIndex(-100)
        }
        .onAppear(perform: self.tuner.start)
        .onDisappear(perform: self.tuner.stop)
    }

    init(
        selectedNote: Note? = nil,
        displayMode: Binding<NoteDisplayMode> = .constant(.default),
        tuner: Tuner = .init()
    ) {
        self._selectedNote = .init(initialValue: selectedNote)
        self._noteDisplayMode = displayMode
        self._tuner = .init(wrappedValue: tuner)
    }
}

// MARK: - Previews

struct TunerView_Previews: PreviewProvider {
    private static let note: Note = .standard
    
    static var previews: some View {
        Group {
            // No Selected Note, Tuner Inactive
            TunerView()

            // Selected Note, Tuner Inactive
            TunerView(selectedNote: Self.note)

            // No Selected Note, Tuner Listening
            TunerView(tuner: .mockedListening(note: Self.note))
        }
        .previewMatrix(.sizeThatFits)
    }
}

struct TunerView_AccuracyPreviews: PreviewProvider {
    private static let note: Note = .standard
    
    static var previews: some View {
        Group {
            // Selected Note, Tuner Listening and Inaccurate
            TunerView(
                selectedNote: Self.note,
                tuner: .mockedListening(frequency: Self.note.frequency + 100)
            )

            // Selected Note, Tuner Listening and Close
            TunerView(
                selectedNote: Self.note,
                tuner: .mockedListening(frequency: Self.note.frequency + 40)
            )

            // Selected Note, Tuner Listening and Closest
            TunerView(
                selectedNote: Self.note,
                tuner: .mockedListening(frequency: Self.note.frequency + 1)
            )
        }
        .previewMatrix(.sizeThatFits, colorSchemes: [.dark])
    }
}
