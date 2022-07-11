// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
import InstrumentKit
import MusicKit
import SwiftUI
import TunerKit

struct TunerView: View {
    @StateObject private var tuner = Tuner()

    @Binding var lockedNote: Note?
    @Binding var noteDisplayMode: NoteDisplayMode

    @State private var isShowingNotePicker = false

    var body: some View {
        ZStack {
            VStack {
                Group {
                    if let lockedNote = self.$lockedNote.trySafeBinding() {
                        ActiveNoteView(
                            note: lockedNote,
                            data: self.tuner.data
                        )
                    } else {
                        Button(action: self.showNotePicker) {
                            Text("Select a Note")
                                .opacity(0.35)
                        }
                        .sheet(isPresented: self.$isShowingNotePicker) {
                            NotePicker(selection: self.$lockedNote)
                        }
                    }
                }
                .font(.title2)
                .padding(.vertical, 48)

//                ActiveTuningView(
//                    tuning: .constant(Instrument.guitar.standardTuning),
//                    data: self.tuner.data
//                )

                Spacer()
            }
            
            NoteView(
                note: self.tuner.data.note,
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
        lockedNote: Binding<Note?> = .constant(nil),
        displayMode: Binding<NoteDisplayMode> = .constant(.default)
    ) {
        self._lockedNote = lockedNote
        self._noteDisplayMode = displayMode
    }

    private func showNotePicker() {
        self.isShowingNotePicker.toggle()
    }
}

struct ActiveNoteView: View {
    @Binding var note: Note
    let data: TunerData

    var body: some View {
        Text(self.note.name)
            .padding()
    }
}

struct ActiveTuningView: View {
    @Binding var tuning: Tuning
    let data: TunerData

    var body: some View {
        HStack(spacing: 16) {
            ForEach(self.tuning.notes) { note in
                Group {
                    if let closestNote = self.closestNote {
                        Text(note.name)
                            .fontWeight(note == closestNote ? .bold : .medium)
                            .opacity(note == closestNote ? 1 : 0.65)
                    } else {
                        Text(note.name)
                    }
                }
                .foregroundColor(.white)
            }
        }
        .padding()
    }

    private var closestNote: Note? {
        self.tuning.notes.closest(to: self.data.frequency)
    }
}

// MARK: - Previews

struct ActiveTuningView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTuningView(
            tuning: .constant(Instrument.guitar.standardTuning),
            data: .mocked
        )
        .background(Color.theme.inactiveTunerBackgroundColor)
        .previewMatrix(.sizeThatFits)
    }
}

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
            .previewMatrix(.sizeThatFits)
    }
}
