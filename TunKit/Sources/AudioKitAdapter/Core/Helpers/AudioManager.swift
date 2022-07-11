// Copyright © 2022 Brian Drelling. All rights reserved.

#if !os(macOS)

import AudioKit
import AVFoundation

public final class AudioManager {
    // TODO: Remove shared instance, look into Resolver/Factory.
    public static var shared = AudioManager()
    
    private let bufferLength: Settings.BufferLength = .short
    
    private let session: AVAudioSession
    
    public init() {
        self.session = AVAudioSession.sharedInstance()
    }
    
    public func start() throws {
        try self.session.setPreferredIOBufferDuration(self.bufferLength.duration)
        try self.session.setCategory(
            .playAndRecord,
            options: [.defaultToSpeaker, .mixWithOthers]
        )
        try self.session.setActive(true)
    }
}

#endif
