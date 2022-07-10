// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
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
                Text(note.name)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

// MARK: - Previews

struct ActiveTuningView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTuningView(
            tuning: .constant(Instrument.guitar.standardTuning),
            data: .mocked
        )
        .background(Color.inactive)
        .previewMatrix(.sizeThatFits)
    }
}

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
            .previewMatrix(.currentDevice)
    }
}
