// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public protocol MusicMathCalculating {}

public extension MusicMath {
    #warning("Figure out how to replace 440 with the note.frequency without recursively crashing the app.")
    static let standardNoteFrequency: Float = 440
    static var precision: Float = 100.0
}

public extension MusicMathCalculating {
    // MARK: Half Step Interval

    private static func intervalForFrequency(_ frequency: Float, from note: Note = .standard) -> Int {
        let numberOfSemitones = Float(Semitone.count)
        return Int(round(numberOfSemitones * log2f(frequency / note.frequency)))
    }

    private static func interval(
        from fromNote: (semitone: Semitone, octave: Int),
        to toNote: (semitone: Semitone, octave: Int)
    ) -> Int {
        var halfSteps: Int = fromNote.semitone.index - toNote.semitone.index
        halfSteps += Semitone.allCases.count * (fromNote.octave - toNote.octave)

        return halfSteps
    }

    private static func interval(from fromNote: Note, to toNote: Note) -> Int {
        self.interval(from: (fromNote.note, fromNote.octave), to: (toNote.note, toNote.octave))
    }

    private static func standardInterval(for note: Note) -> Int {
        self.interval(from: note, to: .standard)
    }

    private static func standardInterval(for note: (semitone: Semitone, octave: Int)) -> Int {
        self.interval(from: note, to: (Note.standard.note, Note.standard.octave))
    }

    private static func baseInterval(for note: Note) -> Int {
        self.interval(from: note, to: .lowest)
    }

    private static func baseInterval(for note: (Semitone, Int)) -> Int {
        self.interval(from: note, to: (Note.lowest.note, Note.lowest.octave))
    }

    // MARK: Frequency

    static func frequencyForInterval(_ interval: Int) -> Float {
        // Multiply the frequency by 2^(n/12), where n is the number of half-steps away from the reference note.
        let power = Float(interval) / Float(Semitone.count)
        let frequency = MusicMath.standardNoteFrequency * powf(2, power)

        return round(frequency * MusicMath.precision) / MusicMath.precision
    }

    static func frequencyForNote(_ semitone: Semitone, octave: Int) -> Float {
        let interval = Self.standardInterval(for: (semitone, octave))
        return self.frequencyForInterval(interval)
    }

    static func frequencyForNote(_ note: Note) -> Float {
        self.frequencyForNote(note.note, octave: note.octave)
    }

    // MARK: Semitone

    static func semitoneForInterval(_ interval: Int, from note: Note = .standard) -> Semitone {
        // First, get the interval of the standard note from the lowest note, C0.
        let baseInterval = self.baseInterval(for: note)

        // Next, add the relative interval we're calculating to the standard note's inteval.
        // This will give us the resultant Semitone's interval from the lowest note, C0.
        let resultInterval = baseInterval + interval

        // Finally, determine the index of the Semitone in its array using the remainder operation.
        let semitoneIndex = resultInterval % Semitone.count

        guard semitoneIndex >= 0 else {
            let reversedIndex = abs(semitoneIndex)
            return Semitone.allCases.reversed()[reversedIndex]
        }

        return Semitone.allCases[semitoneIndex]
    }

    static func semitoneForFrequency(_ frequency: Float, from note: Note = .standard) -> Semitone {
        let interval = self.intervalForFrequency(frequency, from: note)
        return self.semitoneForInterval(interval, from: note)
    }

    // MARK: Octave

    static func octaveForInterval(_ interval: Int, from relativeNote: Note = .standard) -> Int {
        let count = Semitone.count
        let resNegativeIndex = relativeNote.octave - (abs(interval) + 2) / count
        let resPositiveIndex = relativeNote.octave + (interval + 9) / count

        return interval < 0
            ? resNegativeIndex
            : resPositiveIndex
    }

    static func octaveForFrequency(_ frequency: Float) -> Int {
        let interval = self.intervalForFrequency(frequency)
        return self.octaveForInterval(interval)
    }

    // MARK: Note

    static func noteForInterval(_ interval: Int, from relativeNote: Note = .standard) -> Note {
        let frequency = self.frequencyForInterval(interval)
        let semitone = self.semitoneForInterval(interval, from: relativeNote)
        let octave = self.octaveForInterval(interval, from: relativeNote)

        return .init(semitone, octave: octave, frequency: frequency)
    }

    static func noteForFrequency(_ frequency: Float) -> Note {
        let interval = self.intervalForFrequency(frequency)
        return self.noteForInterval(interval)
    }
}
