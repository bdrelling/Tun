// Copyright © 2022 Brian Drelling. All rights reserved.

public struct Instrument: Equatable {
    public let name: String
    public let numberOfStrings: Int
}

// MARK: - Supporting Types

public enum InstrumentType: String {
    case bass

    case banjo

    /// The guitar is a transposing instrument; that is, music for guitars is notated one octave higher than the true pitch.
    case guitar

    case mandolin

    case ukulele

    case violin
}

// MARK: - Convenience

public extension Instrument {
    static let guitar: Self = .init(name: "Guitar", numberOfStrings: 6)
}
