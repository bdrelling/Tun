// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKit
import AVFoundation

final class AudioManager {
    // TODO: Remove shared instance, look into Resolver/Factory.
    static var shared = AudioManager()

    private let bufferLength: Settings.BufferLength = .short

    #if !os(macOS)
        private let session: AVAudioSession
    #endif

    private init() {
        #if !os(macOS)
            self.session = AVAudioSession.sharedInstance()
        #endif
    }

    func start() throws {
        #if !os(macOS)
            try self.session.setPreferredIOBufferDuration(self.bufferLength.duration)
            try self.session.setCategory(
                .playAndRecord,
                options: [.defaultToSpeaker, .mixWithOthers]
            )
            try self.session.setActive(true)
        #endif
    }
}
