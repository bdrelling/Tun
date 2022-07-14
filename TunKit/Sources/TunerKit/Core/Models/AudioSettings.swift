import SwiftUI

public final class AudioSettings: ObservableObject {
    public static let allowedNoiseSensitivityThresholds: ClosedRange<Float> = 0.05 ... 1.0
    
    /// Whether or not audio recording is enabled.
    @Published public var recordingEnabled: Bool
    
    /// The amplitude threshold for when the mic begins to pick up audio, in order to suppress unwanted background noise.
    /// The lower then number, the more sensitive -- meaning that more audio is detected.
    @Published public var noiseSensitivityThreshold: Float
    
    public init(
        recordingEnabled: Bool,
        noiseSensitivityThreshold: Float
    ) {
        self.recordingEnabled = recordingEnabled
        self.noiseSensitivityThreshold = noiseSensitivityThreshold
    }
}

public extension AudioSettings {
    static let `default` = AudioSettings(
        recordingEnabled: true,
        noiseSensitivityThreshold: 0.15
    )
}

public extension AudioSettings {
    static let mocked = AudioSettings(
        recordingEnabled: false,
        noiseSensitivityThreshold: 2.46
    )
}
