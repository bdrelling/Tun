// Copyright © 2022 Brian Drelling. All rights reserved.

import Combine
import InstrumentKit
import MusicKit
import SwiftUI
import TunerKit

struct TunerView: View {
    @StateObject private var tuner = Tuner()

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
        selectedNote: Note? = nil,
        displayMode: Binding<NoteDisplayMode> = .constant(.default)
    ) {
        self._selectedNote = .init(initialValue: selectedNote)
        self._noteDisplayMode = displayMode
    }
}

// MARK: - Previews

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        // Inactive, No Note Selected
        // Active, No Note Selected
        
        
        // Inactive, Note Selected
        // Active, Note Selected but Inaccurate
        // Active, Note Selected but Close
        // Active, Note Selected but Closest
        
        Group {
            TunerView(selectedNote: nil)
            TunerView(selectedNote: .middleA)
        }
            .previewMatrix(.sizeThatFits)
    }
}
