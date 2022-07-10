// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
import InstrumentKit
import MusicKit
import SwiftUI
import TunerKit

struct TunerView: View {
    @StateObject private var tuner = Tuner()
    @Binding var noteDisplayMode: NoteDisplayMode

    var body: some View {
        ZStack {
            VStack {
                ActiveTuningView(
                    tuning: .constant(Instrument.guitar.standardTuning),
                    data: self.tuner.data
                )
                .font(.title2)
                .padding(.top, 100)

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

    init(displayMode: Binding<NoteDisplayMode> = .constant(.default)) {
        self._noteDisplayMode = displayMode
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
            .previewMatrix(.currentDevice)
    }
}
