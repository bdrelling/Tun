// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
import InstrumentKit
import MusicKit
import SwiftUI
import TunerKit

struct TunerView: View {
    @StateObject private var viewModel: ViewModel

    @State var selectedNote: Note?

    @Binding var noteDisplayMode: NoteDisplayMode

    var body: some View {
        ZStack {
            VStack {
                NotePickerButton(
                    selection: self.$selectedNote,
                    data: self.viewModel.tunerData
                )
                .padding(.vertical, 48)

//                ActiveTuningView(
//                    tuning: .constant(Instrument.guitar.standardTuning),
//                    data: self.tuner.data
//                )

                Spacer()
            }

            NoteView(
                detectedNote: self.viewModel.tunerData.note,
                selectedNote: self.selectedNote,
                isDetectingAudio: self.viewModel.isDetectingAudio,
                displayMode: self.noteDisplayMode
            )
            .edgesIgnoringSafeArea(.all)
            .zIndex(-100)
        }
        .onAppear(perform: self.viewModel.start)
        .onDisappear(perform: self.viewModel.stop)
    }

    init(
        tuner: Tuner,
        selectedNote: Note? = nil,
        displayMode: Binding<NoteDisplayMode> = .constant(.default)
    ) {
        self._selectedNote = .init(initialValue: selectedNote)
        self._noteDisplayMode = displayMode
        self._viewModel = .init(wrappedValue: .init(tuner: tuner))
    }
}

// MARK: - View Model

private extension TunerView {
    final class ViewModel: ObservableObject {
        private let tuner: Tuner

        @Published var tunerData: TunerData = .inactive
        @Published var isDetectingAudio: Bool = false

        init(tuner: Tuner) {
            self.tuner = tuner

            self.tuner.$data.assign(to: &self.$tunerData)
            self.tuner.$isDetectingAudio.assign(to: &self.$isDetectingAudio)
        }

        func start() {
            self.tuner.start()
        }

        func stop() {
            self.tuner.stop()
        }
    }
}

// MARK: - Previews

struct TunerView_Previews: PreviewProvider {
    private static let note: Note = .standard

    static var previews: some View {
        Group {
            // No Selected Note, Tuner Inactive
            TunerView(tuner: .mocked())

            // Selected Note, Tuner Inactive
            TunerView(tuner: .mocked(), selectedNote: Self.note)

            // No Selected Note, Tuner Listening
            TunerView(tuner: .mockedDetecting(note: Self.note))
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
                tuner: .mockedDetecting(frequency: Self.note.frequency + 100),
                selectedNote: Self.note
            )

            // Selected Note, Tuner Listening and Close
            TunerView(
                tuner: .mockedDetecting(frequency: Self.note.frequency + 40),
                selectedNote: Self.note
            )

            // Selected Note, Tuner Listening and Closest
            TunerView(
                tuner: .mockedDetecting(frequency: Self.note.frequency + 1),
                selectedNote: Self.note
            )
        }
        .previewMatrix(.sizeThatFits, colorSchemes: [.dark])
    }
}
