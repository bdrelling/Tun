// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI
import TunerKit

final class AppSettings: ObservableObject {
    @Published var audio: AudioSettings
    @Published var noteDisplayMode: NoteDisplayMode

    // FIXME: For this to be configurable at runtime, updates to this need to start and stop the tuner.
    @Published var networkingEnabled: Bool

    init(
        audioSettings: AudioSettings,
        noteDisplayMode: NoteDisplayMode,
        networkingEnabled: Bool? = nil
    ) {
        audioSettings.recordingEnabled = !TunApp.shouldMockExternalServices
        self.audio = audioSettings

        self.noteDisplayMode = noteDisplayMode
        self.networkingEnabled = networkingEnabled ?? !TunApp.shouldMockExternalServices
    }
}

extension AppSettings {
    static let `default` = AppSettings(
        audioSettings: .default,
        noteDisplayMode: .both
    )
}

extension AppSettings {
    static let mocked = AppSettings(
        audioSettings: .mocked,
        noteDisplayMode: .both
    )
}
