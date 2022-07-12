import MusicKit

public extension Tuner {
    static func mocked(data: TunerData = .inactive, isDetectingAudio: Bool = false) -> Self {
        .init(data: data, isDetectingAudio: isDetectingAudio)
    }
    
    static func mockedListening(data: TunerData = .inactive) -> Self {
        .mocked(data: data, isDetectingAudio: true)
    }
    
    static func mockedListening(note: Note) -> Self {
        .mocked(data: .mocked(note), isDetectingAudio: true)
    }
    
    static func mockedListening(frequency: Float) -> Self {
        .mocked(data: .mocked(frequency: frequency), isDetectingAudio: true)
    }
}
