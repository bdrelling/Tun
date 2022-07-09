// Copyright © 2022 Brian Drelling. All rights reserved.

//// Copyright © 2022 Brian Drelling. All rights reserved.
//
// import Combine
// import TunerKit
//
// extension TunerView {
//    final class ViewModel: ObservableObject, TunerCoordinating {
//        let tuner: Tuner
//
//        @Published var noteDisplayMode: NoteDisplayMode
//
//        @Published var tunerData: TunerData = .inactive
//        @Published var isActive: Bool = false
//
//        init(noteDisplayMode: NoteDisplayMode = .default, tuner: Tuner = .init()) {
//            self.noteDisplayMode = noteDisplayMode
//            self.tuner = tuner
//            self.prepareToListen(to: tuner)
//        }
//
//        private func prepareToListen(to tuner: Tuner) {
//            self.tuner.$data
//                .assign(to: &self.$tunerData)
//
//            self.tuner.$isListening
//                .assign(to: &self.$isActive)
//        }
//    }
// }
