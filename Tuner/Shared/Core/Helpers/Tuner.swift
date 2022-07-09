// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKit
import AudioKitEX
import AudioToolbox
import Combine
import KippleCore
import MusicKit
import SoundpipeAudioKit
import TunerKit

final class Tuner: ObservableObject {
    /// The amplitude threshold for when the mic begins to pick up audio, in order to suppress unwanted background noise.
    /// The lower then number, the more sensitive -- meaning that more audio is detected.
    private static let noiseSensitivityThreshold: AUValue = 0.1

    @Published var data: TunerData = .inactive
    @Published var isListening: Bool = false

    private(set) var engine = AudioEngine()
    private(set) var initialDevice: Device!

    private(set) var mic: AudioEngine.InputNode!
    private(set) var silence: Fader!
    private var tracker: PitchTap!

    private var isInitialized: Bool = false

    init() {}

    func initialize() {
        guard !self.isInitialized else {
            return
        }

        guard let input = self.engine.input else {
            print("Unable to retrieve engine.input.")
            return
        }

        #if os(macOS)
            let device = self.engine.device
        #else
            guard let device = self.engine.inputDevice else {
                print("Unable to retrieve engine.inputDevice.")
                return
            }
        #endif

        self.initialDevice = device

        self.mic = input
        #warning("Can I remove this property?")
        self.silence = Fader(self.mic, gain: 0)
        self.engine.output = self.silence

        self.tracker = PitchTap(self.mic) { pitch, amp in
            DispatchQueue.main.async {
                self.update(pitch[0], amp[0])
            }
        }

        self.isInitialized = true
    }

    func update(_ frequency: AUValue, _ amplitude: AUValue) {
        // Reduces sensitivity to background noise to prevent random / fluctuating data.
        self.isListening = amplitude > Self.noiseSensitivityThreshold

        guard self.isListening else {
            return
        }

        let note = MusicMath.noteForFrequency(frequency)
        self.data = .init(frequency: frequency, amplitude: amplitude, note: note)
    }

    func start() {
        guard !Kipple.isRunningInXcodePreview else {
            return
        }

        self.initialize()

        do {
            try self.engine.start()
            self.tracker.start()
        } catch {
            print(error.localizedDescription)
        }
    }

    func stop() {
        guard !Kipple.isRunningInXcodePreview else {
            return
        }

        self.engine.stop()
    }
}
