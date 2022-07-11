import MusicKit

public extension Tuner {
    static func mocked(data: TunerData = .inactive, isListening: Bool = false) -> Self {
        .init(data: data, isListening: isListening)
    }
    
    static func mockedListening(data: TunerData = .inactive) -> Self {
        .mocked(data: data, isListening: true)
    }
    
    static func mockedListening(note: Note) -> Self {
        .mocked(data: .mocked(note), isListening: true)
    }
    
    static func mockedListening(frequency: Float) -> Self {
        .mocked(data: .mocked(frequency: frequency), isListening: true)
    }
}
