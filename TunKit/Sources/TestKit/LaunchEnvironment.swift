// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct LaunchEnvironment: Decodable {
    public let colorScheme: ColorScheme?
    public let appStoreScreenshotIndex: Int?
    public let isDetectingAudio: Bool?
    public let tunerFrequency: Float?
    public let tunerAmplitude: Float?
    public let selectedSemitoneValue: Int?
    public let selectedOctaveValue: Int?

    public init(
        colorScheme: ColorScheme? = nil,
        appStoreScreenshotIndex: Int? = nil,
        isDetectingAudio: Bool? = nil,
        tunerFrequency: Float? = nil,
        tunerAmplitude: Float? = nil,
        selectedSemitoneValue: Int? = nil,
        selectedOctaveValue: Int? = nil
    ) {
        self.colorScheme = colorScheme
        self.appStoreScreenshotIndex = appStoreScreenshotIndex
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
        case colorScheme
        case appStoreScreenshotIndex
        case isDetectingAudio
        case tunerFrequency
        case tunerAmplitude
        case selectedSemitone
        case selectedOctave
    }
}

public extension LaunchEnvironment {
    enum ColorScheme: String, Decodable {
        case light = "Light"
        case dark = "Dark"
    }
}

// MARK: - Extensions

public extension LaunchEnvironment {
    init(from launchDictionary: [String: String]) {
        if let colorSchemeValue = launchDictionary.string(for: .colorScheme) {
            self.colorScheme = .init(rawValue: colorSchemeValue)
        } else {
            self.colorScheme = nil
        }

        self.appStoreScreenshotIndex = launchDictionary.int(for: .appStoreScreenshotIndex)
        self.isDetectingAudio = launchDictionary.bool(for: .isDetectingAudio)
        self.tunerFrequency = launchDictionary.float(for: .tunerFrequency)
        self.tunerAmplitude = launchDictionary.float(for: .tunerAmplitude)
        self.selectedSemitoneValue = launchDictionary.int(for: .selectedSemitone)
        self.selectedOctaveValue = launchDictionary.int(for: .selectedOctave)
    }

    private func stringValue(for key: Key) -> String? {
        switch key {
        case .colorScheme:
            if let colorScheme = self.colorScheme {
                return "\(colorScheme.rawValue)"
            }
        case .appStoreScreenshotIndex:
            if let appStoreScreenshotIndex = self.appStoreScreenshotIndex {
                return "\(appStoreScreenshotIndex)"
            }
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

// MARK: - Extensions

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
