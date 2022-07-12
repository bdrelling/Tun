import Foundation

public struct LaunchEnvironment {
    public let isDetectingAudio: Bool?
    public let tunerFrequency: Float?
    public let tunerAmplitude: Float?
    public let selectedSemitoneValue: Int?
    public let selectedOctaveValue: Int?
    
    public init(
        isDetectingAudio: Bool? = nil,
        tunerFrequency: Float? = nil,
        tunerAmplitude: Float? = nil,
        selectedSemitoneValue: Int? = nil,
        selectedOctaveValue: Int? = nil
    ) {
        self.isDetectingAudio = isDetectingAudio
        self.tunerFrequency = tunerFrequency
        self.tunerAmplitude = tunerAmplitude
        self.selectedSemitoneValue = selectedSemitoneValue
        self.selectedOctaveValue = selectedOctaveValue
    }
}

// MARK: - Supporting Types

extension LaunchEnvironment {
    enum Key: String, CaseIterable {
        case isDetectingAudio
        case tunerFrequency
        case tunerAmplitude
        case selectedSemitone
        case selectedOctave
    }
}

// MARK: - Extensions

public extension LaunchEnvironment {
    init(from launchDictionary: [String: String]) {
        self.isDetectingAudio = launchDictionary.bool(for: .isDetectingAudio) ?? false
        self.tunerFrequency = launchDictionary.float(for: .tunerFrequency)
        self.tunerAmplitude = launchDictionary.float(for: .tunerAmplitude)
        self.selectedSemitoneValue = launchDictionary.int(for: .selectedSemitone)
        self.selectedOctaveValue = launchDictionary.int(for: .selectedOctave)
    }
    
    private func stringValue(for key: Key) -> String? {
        switch key {
        case .isDetectingAudio:
            if let isDetectingAudio = self.isDetectingAudio {
                return isDetectingAudio ? "true" : "false"
            }
        case .tunerFrequency:
            if let tunerFrequency = self.tunerFrequency {
                return "\(tunerFrequency)"
            }
        case .tunerAmplitude:
            if let tunerAmplitude = self.tunerAmplitude {
                return "\(tunerAmplitude)"
            }
        case .selectedSemitone:
            if let selectedSemitone = self.selectedSemitoneValue {
                return "\(selectedSemitone)"
            }
        case .selectedOctave:
            if let selectedOctave = self.selectedOctaveValue {
                return "\(selectedOctave)"
            }
        }
        
        return nil
    }
    
    func toStringDictionary() -> [String: String] {
        var dictionary: [String: String] = [:]
        
        for key in Key.allCases {
            guard let stringValue = self.stringValue(for: key) else {
                continue
            }
            
            dictionary[key.rawValue] = stringValue
        }
        
        return dictionary
    }
}

extension Dictionary where Key == String, Value == String {
    subscript(_ key: LaunchEnvironment.Key) -> String? {
        self[key.rawValue]
    }
    
    func bool(for key: LaunchEnvironment.Key) -> Bool? {
        if let value = self[key.rawValue] {
            return .init(value)
        } else {
            return nil
        }
    }
    
    func double(for key: LaunchEnvironment.Key) -> Double? {
        if let value = self[key.rawValue] {
            return .init(value)
        } else {
            return nil
        }
    }
    
    func float(for key: LaunchEnvironment.Key) -> Float? {
        if let value = self[key.rawValue] {
            return .init(value)
        } else {
            return nil
        }
    }
    
    func int(for key: LaunchEnvironment.Key) -> Int? {
        if let value = self[key.rawValue] {
            return .init(value)
        } else {
            return nil
        }
    }
    
    func string(for key: LaunchEnvironment.Key) -> String? {
        self[key]
    }
}

public extension ProcessInfo {
    var launchEnvironment: LaunchEnvironment {
        .init(from: self.environment)
    }
}
