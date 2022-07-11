// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKit
import AudioKitEX
import AudioToolbox
import SoundpipeAudioKit
import SwiftUI

struct AudioKitTunerData {
    var pitch: Float = 0.0
    var amplitude: Float = 0.0
    var noteNameWithSharps = "-"
    var noteNameWithFlats = "-"
}

class AudioKitTunerConductor: ObservableObject {
    @Published var data = AudioKitTunerData()

    let engine = AudioEngine()
    let initialDevice: Device

    let mic: AudioEngine.InputNode
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader

    var tracker: PitchTap!

    let noteFrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, 25.96, 27.5, 29.14, 30.87]
    let noteNamesWithSharps = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]
    let noteNamesWithFlats = ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"]

    init() {
        guard let input = engine.input else { fatalError() }

        #if os(macOS)
            let device = self.engine.device
        #else
            guard let device = engine.inputDevice else { fatalError() }
        #endif

        self.initialDevice = device

        self.mic = input
        self.tappableNodeA = Fader(self.mic)
        self.tappableNodeB = Fader(self.tappableNodeA)
        self.tappableNodeC = Fader(self.tappableNodeB)
        self.silence = Fader(self.tappableNodeC, gain: 0)
        self.engine.output = self.silence

        self.tracker = PitchTap(self.mic) { pitch, amp in
            DispatchQueue.main.async {
                self.update(pitch[0], amp[0])
            }
        }
    }

    func update(_ pitch: AUValue, _ amp: AUValue) {
        // Reduces sensitivity to background noise to prevent random / fluctuating data.
        guard amp > 0.1 else { return }

        self.data.pitch = pitch
        self.data.amplitude = amp

        var frequency = pitch
        while frequency > Float(self.noteFrequencies[self.noteFrequencies.count - 1]) {
            frequency /= 2.0
        }
        while frequency < Float(self.noteFrequencies[0]) {
            frequency *= 2.0
        }

        var minDistance: Float = 10000.0
        var index = 0

        for possibleIndex in 0 ..< self.noteFrequencies.count {
            let distance = fabsf(Float(noteFrequencies[possibleIndex]) - frequency)
            if distance < minDistance {
                index = possibleIndex
                minDistance = distance
            }
        }
        let octave = Int(log2f(pitch / frequency))
        self.data.noteNameWithSharps = "\(self.noteNamesWithSharps[index])\(octave)"
        self.data.noteNameWithFlats = "\(self.noteNamesWithFlats[index])\(octave)"
    }

    func start() {
        do {
            try self.engine.start()
            self.tracker.start()
        } catch let err {
            Log(err)
        }
    }

    func stop() {
        self.engine.stop()
    }
}

struct AudioKitTunerView: View {
    @StateObject var conductor = AudioKitTunerConductor()

    var body: some View {
        VStack {
            HStack {
                Text("Frequency")
                Spacer()
                Text("\(conductor.data.pitch, specifier: "%0.1f")")
            }.padding()

            HStack {
                Text("Amplitude")
                Spacer()
                Text("\(conductor.data.amplitude, specifier: "%0.1f")")
            }.padding()

            HStack {
                Text("Note Name")
                Spacer()
                Text("\(conductor.data.noteNameWithSharps) / \(conductor.data.noteNameWithFlats)")
            }.padding()
        }
        .onAppear {
            conductor.start()
        }
        .onDisappear {
            conductor.stop()
        }
    }
}

struct AudioKitTunerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioKitTunerView()
    }
}
