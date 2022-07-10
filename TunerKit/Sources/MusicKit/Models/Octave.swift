// Copyright © 2022 Brian Drelling. All rights reserved.

public enum Octave: Int, CaseIterable {
    case subContra = 0 // A0 is the lowest pitch on a full piano
    case contra = 1
    case great = 2
    case small = 3
    case secondSmall = 4 // Contains both middle C (C4) and middle a (A4, 440 Hz)
    case thirdSmall = 5
    case fourthSmall = 6
    case fifthSmall = 7
    case sixthSmall = 8 // C8 is the highest pitch on a full piano
}

// MARK: - Extensions

extension Octave: Identifiable {
    public var id: RawValue {
        self.rawValue
    }
}

public extension Octave {
    var name: String {
        switch self {
        case .subContra:
            return "sub-contra"
        case .contra:
            return "contra"
        case .great:
            return "great"
        case .small:
            return "small"
        case .secondSmall:
            return "2nd small"
        case .thirdSmall:
            return "3rd small"
        case .fourthSmall:
            return "4th small"
        case .fifthSmall:
            return "5th small"
        case .sixthSmall:
            return "6th small"
        }
    }
}

// MARK: - Aliases

public extension Octave {
    static let oneLine: Self = .secondSmall
    static let twoLine: Self = .thirdSmall
    static let threeLine: Self = .fourthSmall
    static let fourLine: Self = .fifthSmall
    static let fiveLine: Self = .sixthSmall
}