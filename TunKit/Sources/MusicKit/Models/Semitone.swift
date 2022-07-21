// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct Semitone: Equatable, Hashable {
    public let name: String
    public let index: Int
    public let frequency: Float

    // TODO: Find better name, like "isSemitone" -- but that isn't accurate
    public var isSharp: Bool {
        switch self {
        case .cSharp, .dSharp, .fSharp, .gSharp, .aSharp:
            return true
        default:
            return false
        }
    }

    private init(_ name: String, index: Int, frequency: Float) {
        self.name = name
        self.index = index
        self.frequency = frequency
    }
}

// MARK: - Extensions

extension Semitone: CaseIterable {
    public static let allCases: [Self] = [.c, .cSharp, .d, .dSharp, .e, .f, .fSharp, .g, .gSharp, .a, .aSharp, .b]
    public static let allFrequencies = Self.allCases.map(\.frequency)
}

extension Semitone: Identifiable {
    public var id: Int {
        self.index
    }
}

extension Semitone: CustomStringConvertible {
    public var description: String {
        self.name
    }
}

extension Semitone: RawRepresentable {
    public var rawValue: Int {
        self.index
    }

    public init?(rawValue: Int) {
        if let semitone = Semitone.allCases.first(where: { $0.index == rawValue }) {
            self = semitone
        } else {
            return nil
        }
    }
}

// MARK: - Convenience

public extension Semitone {
    // The total number of Semitones in an octave.
    // This value should always be 12, but we'll calculate it from the array count for good measure.
    // To avoid using the array count every time we need it, which will be quite often with music math calculations,
    // we'll store this as a constant.
    static let count: Int = Self.allCases.count

    /// https://en.wikipedia.org/wiki/Semitone#Equal_temperament
    /// 12-tone equal temperament is a form of meantone tuning in which the diatonic and chromatic semitones are exactly the same, because its circle of fifths has no break. Each semitone is equal to one twelfth of an octave.
    /// This is a ratio of 2^1/12 (approximately 1.05946), or 100 cents, and is 11.7 cents narrower than the 16:15 ratio (its most common form in just intonation, discussed below).
//    static let intervalRatio: Float = 1.059463094359

    static let c: Self = .init("C", index: 0, frequency: 16.35)
    static let cSharp: Self = .init("C♯", index: 1, frequency: 17.32)
    static let d: Self = .init("D", index: 2, frequency: 18.35)
    static let dSharp: Self = .init("D♯", index: 3, frequency: 19.45)
    static let e: Self = .init("E", index: 4, frequency: 20.60)
    static let f: Self = .init("F", index: 5, frequency: 21.83)
    static let fSharp: Self = .init("F♯", index: 6, frequency: 23.12)
    static let g: Self = .init("G", index: 7, frequency: 24.50)
    static let gSharp: Self = .init("G♯", index: 8, frequency: 25.96)
    static let a: Self = .init("A", index: 9, frequency: 27.50)
    static let aSharp: Self = .init("A♯", index: 10, frequency: 29.14)
    static let b: Self = .init("B", index: 11, frequency: 30.87)
}

// Engineering Toolbox
// https://www.engineeringtoolbox.com/note-frequencies-d_520.html

// E2 = 82.41
// A2 = 110.0
// D3 = 146.8
// G3 = 196.0
// B3 = 246.9
// E4 = 329.6

// Wikipedia
// https://en.wikipedia.org/wiki/Guitar_tunings#Standard

// E2 = 82.41
// A2 = 110.00
// D3 = 146.83
// G3 = 196.0
// B3 = 246.94
// E4 = 329.63
