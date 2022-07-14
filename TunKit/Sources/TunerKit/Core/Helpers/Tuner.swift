// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKit
import AudioKitEX
import AudioToolbox
import Combine
import KippleCore
import MusicKit
import SoundpipeAudioKit

public final class Tuner: ObservableObject {
    private let audioSettings: AudioSettings

    @Published public private(set) var data: TunerData 
    
    /// Whether or not the Tuner is actively detecting audio.
    @Published public private(set) var isDetectingAudio: Bool

    private var engine = AudioEngine()

    private var mic: AudioEngine.InputNode!
    private var silencer: Fader?
    private var tracker: PitchTap?

    private var isInitialized: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()

    public init(
        audioSettings: AudioSettings,
        data: TunerData = .inactive,
        isDetectingAudio: Bool = false
    ) {
        self.audioSettings = audioSettings
        self.data = data
        self.isDetectingAudio = isDetectingAudio
        
        self.audioSettings.$recordingEnabled
            .sink(receiveValue: self.recordingEnabledDidChange)
            .store(in: &self.subscriptions)
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
    
    private func recordingEnabledDidChange(_ recordingEnabled: Bool) {
        // If recording was enabled but the engine is already running, do nothing.
        // Similarly, if it was disabled but the engine is stopped, do nothing.
        guard recordingEnabled != self.engine.avEngine.isRunning else {
            return
        }
        
        if recordingEnabled {
            self.start()
        } else {
            self.stop()
        }
    }

    public func start() {
        guard self.audioSettings.recordingEnabled else {
            return
        }
        
        self.initialize()

        do {
            try self.engine.start()
            self.tracker?.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func pause() {
        guard self.engine.avEngine.isRunning else {
            return
        }
        
        self.engine.pause()
    }

    public func stop() {
        guard self.engine.avEngine.isRunning else {
            return
        }
        
        self.engine.stop()
    }
    
    private func update(_ frequency: AUValue, _ amplitude: AUValue) {
        // Reduces sensitivity to background noise to prevent random / fluctuating data.
        self.isDetectingAudio = amplitude > self.audioSettings.noiseSensitivityThreshold
        
        print(amplitude)

        guard self.isDetectingAudio else {
            return
        }

        let note = MusicMath.noteForFrequency(frequency)
        self.data = .init(frequency: frequency, amplitude: amplitude, note: note)
    }
}
