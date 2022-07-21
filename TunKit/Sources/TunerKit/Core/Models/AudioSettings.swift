// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

public final class AudioSettings: ObservableObject {
    public static let allowedNoiseSensitivityThresholds: ClosedRange<Float> = 0.05 ... 1.0
    public static let allowedCentAccuracyThresholds: ClosedRange<Float> = 0 ... 20

    /// Whether or not audio recording is enabled.
    @Published public var recordingEnabled: Bool

    /// The amplitude threshold for when the mic begins to pick up audio, in order to suppress unwanted background noise.
    /// The lower then number, the more sensitive -- meaning that more audio is detected.
    @Published public var noiseSensitivityThreshold: Float

    /// The number of cents before considering a tuning to be accurate.
    @Published public var centAccuracyThreshold: Float

    public init(
        recordingEnabled: Bool,
        noiseSensitivityThreshold: Float,
        centAccuracyThreshold: Float
    ) {
        self.recordingEnabled = recordingEnabled
        self.noiseSensitivityThreshold = noiseSensitivityThreshold
        self.centAccuracyThreshold = centAccuracyThreshold
    }
}

public extension AudioSettings {
    static let `default` = AudioSettings(
        recordingEnabled: true,
        noiseSensitivityThreshold: 0.15,
        centAccuracyThreshold: 4
    )
}

public extension AudioSettings {
    static let mocked = AudioSettings(
        recordingEnabled: false,
        noiseSensitivityThreshold: 2.46,
        centAccuracyThreshold: 4
    )
}
