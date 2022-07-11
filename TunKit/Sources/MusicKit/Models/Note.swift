// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public struct Note: Equatable {
    public let semitone: Semitone
    public let octave: Octave
    public let frequency: Float

    public var name: String {
        "\(self.semitone.name)\(self.octave.rawValue)"
    }
    
    public init(_ semitone: Semitone, octave: Octave, frequency: Float? = nil) {
        self.semitone = semitone
        self.octave = octave
        self.frequency = frequency ?? MusicMath.frequencyForNote(semitone, octave: octave)
    }
    
    public init(_ semitone: Semitone, octave: Int, frequency: Float? = nil) {
        self.init(
            semitone,
            octave: .init(octave),
            frequency: frequency
        )
    }
}

// MARK: - Extensions

extension Note: Identifiable {
    public var id: String {
        self.name
    }
}

extension Note {
    //    func halfSteps(from otherNote: Note) -> Int {
    //        var halfSteps: Int = self.note.index - otherNote.note.index
    //        halfSteps += Semitone.allCases.count * (self.octave - otherNote.octave)
    //
    //        return halfSteps
    //    }
    //
    //    // Returns the number of half-steps away from the standard note, A4.
    //    var halfStepIntervalFromA4: Int {
    //        self.halfSteps(from: .standard)
    //    }
    //
    //    // Returns the number of half-steps away from the lowest note, C0.
    //    var halfStepIntervalFromlowestNote: Int {
    //        self.halfSteps(from: .c(0))
    //    }
    //
    //    // Returns the number of half-steps away from the highest note, B8.
    //    var halfStepIntervalFromHighestNote: Int {
    //        self.halfSteps(from: .b(8))
    //    }
    //
}

// MARK: - Convenience

public extension Note {
    static func c(_ octave: Int) -> Self {
        .init(.c, octave: octave)
    }

    static func cSharp(_ octave: Int) -> Self {
        .init(.cSharp, octave: octave)
    }

    static func d(_ octave: Int) -> Self {
        .init(.d, octave: octave)
    }

    static func dSharp(_ octave: Int) -> Self {
        .init(.dSharp, octave: octave)
    }

    static func e(_ octave: Int) -> Self {
        .init(.e, octave: octave)
    }

    static func f(_ octave: Int) -> Self {
        .init(.f, octave: octave)
    }

    static func fSharp(_ octave: Int) -> Self {
        .init(.fSharp, octave: octave)
    }

    static func g(_ octave: Int) -> Self {
        .init(.g, octave: octave)
    }

    static func gSharp(_ octave: Int) -> Self {
        .init(.gSharp, octave: octave)
    }

    static func a(_ octave: Int) -> Self {
        .init(.a, octave: octave)
    }

    static func aSharp(_ octave: Int) -> Self {
        .init(.aSharp, octave: octave)
    }

    static func b(_ octave: Int) -> Self {
        .init(.b, octave: octave)
    }
}

// MARK: - Constants

public extension Note {
    // https://en.wikipedia.org/wiki/A440_(pitch_standard)
    static let standard: Self = .init(.a, octave: 4, frequency: 440)
    static let lowest: Self = .init(.c, octave: 0, frequency: Semitone.c.frequency)
    static let highest: Self = .init(.b, octave: 8, frequency: 7920.13)

    static let inactiveNoteSymbol = "-"
}

// MARK: - Aliases

// TODO: Create and extend alias system?
// Source: https://www.liveabout.com/pitch-notation-and-octave-naming-2701389
// "All of the notes may be called out using these systems. F1 is also known as “contra F” or “double pedal F.”
// public extension Note {
//    static let triplePedalC: Self = .c(0)
//    static let doublePedalC: Self = .c(1)
//    static let pedalC: Self = .c(2)
//    static let bassC: Self = .c(3)
//    static let middleC: Self = .c(4)
//    static let trebleC: Self = .c(5)
//    static let topC: Self = .c(6)
//    static let doubleTopC: Self = .c(7)
//    static let doubleHighC: Self = .c(7)
//    static let tripleTopC: Self = .c(8)
//    static let tripleHighC: Self = .c(8)
// }

///// See [Scientific pitch notation](https://en.wikipedia.org/wiki/Scientific_pitch_notation).
/////
///// The guitar is a transposing instrument; that is, music for guitars is notated one octave higher than the true pitch.
///// This is to reduce the need for ledger lines in music written for the instrument, and thus simplify the reading of notes when playing the guitar.
// enum ScientificPitch: Float { ... }
