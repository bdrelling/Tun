// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKit
import AudioKitEX
import AudioToolbox
import Combine
import KippleCore
import MusicKit
import SoundpipeAudioKit

public final class Tuner: ObservableObject {
    // TODO: Make this sensitivity configurable?
    /// The amplitude threshold for when the mic begins to pick up audio, in order to suppress unwanted background noise.
    /// The lower then number, the more sensitive -- meaning that more audio is detected.
    private static let noiseSensitivityThreshold: AUValue = 0.15

    @Published public private(set) var data: TunerData 
    
    /// Whether or not the Tuner is actively detecting audio.
    @Published public private(set) var isDetectingAudio: Bool

    private var engine = AudioEngine()

    private var mic: AudioEngine.InputNode!
    private var silencer: Fader?
    private var tracker: PitchTap?

    private var isInitialized: Bool = false

    public init(data: TunerData = .inactive, isDetectingAudio: Bool = false) {
        self.data = data
        self.isDetectingAudio = isDetectingAudio
    }

    public func initialize() {
        guard !self.isInitialized else {
            return
        }

        guard let input = self.engine.input else {
            print("Unable to retrieve engine.input.")
            return
        }

        self.mic = input
        self.silencer = Fader(self.mic, gain: 0)
        self.engine.output = self.silencer

        self.tracker = PitchTap(self.mic) { pitch, amp in
            DispatchQueue.main.async {
                self.update(pitch[0], amp[0])
            }
        }

        self.isInitialized = true
    }

    public func start() {
        self.initialize()

        do {
            try self.engine.start()
            self.tracker?.start()
        } catch {
            print(error.localizedDescription)
        }
    }

    public func stop() {
        self.engine.stop()
    }
    
    private func update(_ frequency: AUValue, _ amplitude: AUValue) {
        // Reduces sensitivity to background noise to prevent random / fluctuating data.
        self.isDetectingAudio = amplitude > Self.noiseSensitivityThreshold

        guard self.isDetectingAudio else {
            return
        }

        let note = MusicMath.noteForFrequency(frequency)
        self.data = .init(frequency: frequency, amplitude: amplitude, note: note)
    }
}
