// Copyright © 2022 Brian Drelling. All rights reserved.

#if !os(macOS)

import AudioKit
import AVFoundation

public final class AudioManager {
    private let bufferLength: Settings.BufferLength = .short
    
    private let session: AVAudioSession
    
    private let category: AVAudioSession.Category = .playAndRecord
    private var options: AVAudioSession.CategoryOptions {
        #if os(tvOS)
            [.mixWithOthers]
        #else
            [.defaultToSpeaker, .mixWithOthers]
        #endif
    }
    
    public init(session: AVAudioSession = .sharedInstance()) {
        self.session = session
    }
    
    public func start() throws {
        try self.session.setPreferredIOBufferDuration(self.bufferLength.duration)
        
        try self.session.setCategory(
            self.category,
            options: self.options
        )
        
        try self.session.setActive(true)
    }
}

#endif
