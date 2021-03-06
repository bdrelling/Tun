// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public final class MusicMath {}

// MARK: - Supporting Types

public typealias SimpleNote = (semitone: Semitone, octave: Octave)

// MARK: - Constants

public extension MusicMath {
    static var precision: Float = 100.0
}

// MARK: - Extensions

public extension MusicMath {
    // MARK: Half Step Interval

    private static func intervalForFrequency(_ frequency: Float) -> Int {
        let numberOfSemitones = Float(Semitone.count)
        return Int(round(numberOfSemitones * log2f(frequency / Note.standard.frequency)))
    }

    private static func interval(
        from fromNote: SimpleNote,
        to toNote: SimpleNote
    ) -> Int {
        var halfSteps: Int = fromNote.semitone.index - toNote.semitone.index
        halfSteps += Semitone.allCases.count * (fromNote.octave.rawValue - toNote.octave.rawValue)

        return halfSteps
    }

    static func interval(from fromNote: Note, to toNote: Note) -> Int {
        self.interval(from: (fromNote.semitone, fromNote.octave), to: (toNote.semitone, toNote.octave))
    }

    private static func standardInterval(for note: Note) -> Int {
        self.interval(from: note, to: .standard)
    }

    private static func standardInterval(for note: SimpleNote) -> Int {
        self.interval(from: note, to: (Note.standard.semitone, Note.standard.octave))
    }

    private static func baseInterval(for note: Note) -> Int {
        self.interval(from: note, to: .lowest)
    }

    private static func baseInterval(for note: SimpleNote) -> Int {
        self.interval(from: note, to: (Note.lowest.semitone, Note.lowest.octave))
    }

    // MARK: Frequency

    static func frequencyForInterval(_ interval: Int) -> Float {
        // Multiply the frequency by 2^(n/12), where n is the number of half-steps away from the reference note.
        let power = Float(interval) / Float(Semitone.count)
        let frequency = Note.standard.frequency * powf(2, power)

        return round(frequency * MusicMath.precision) / MusicMath.precision
    }

    static func frequencyForNote(_ semitone: Semitone, octave: Octave) -> Float {
        let interval = Self.standardInterval(for: (semitone, octave))
        return self.frequencyForInterval(interval)
    }

    static func frequencyForNote(_ semitone: Semitone, octave: Int) -> Float {
        self.frequencyForNote(semitone, octave: .init(octave))
    }

    static func frequencyForNote(_ note: Note) -> Float {
        self.frequencyForNote(note.semitone, octave: note.octave)
    }

    // MARK: Cents

    static func cents(from fromFrequency: Float, to toFrequency: Float) -> Float {
        let centsPerOctave = Float(Semitone.count * 100)
        return centsPerOctave * log2f(fromFrequency / toFrequency)
    }

    static func cents(from note: Note, to frequency: Float) -> Float {
        self.cents(from: note.frequency, to: frequency)
    }

    static func cents(from fromNote: Note, to toNote: Note) -> Float {
        self.cents(from: fromNote.frequency, to: toNote.frequency)
    }

    // MARK: Semitone

    static func semitoneForInterval(_ interval: Int) -> Semitone {
        // First, get the interval of the standard note from the lowest note, C0.
        let baseInterval = self.baseInterval(for: Note.standard)

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

    static func semitoneForFrequency(_ frequency: Float) -> Semitone {
        let interval = self.intervalForFrequency(frequency)
        return self.semitoneForInterval(interval)
    }

    // MARK: Octave

    static func octaveForInterval(_ interval: Int) -> Int {
        let count = Semitone.count
        let resNegativeIndex = Note.standard.octave.rawValue - (abs(interval) + 2) / count
        let resPositiveIndex = Note.standard.octave.rawValue + (interval + 9) / count

        return interval < 0
            ? resNegativeIndex
            : resPositiveIndex
    }

    static func octaveForFrequency(_ frequency: Float) -> Int {
        let interval = self.intervalForFrequency(frequency)
        return self.octaveForInterval(interval)
    }

    // MARK: Note

    static func noteForInterval(_ interval: Int) -> Note {
        let frequency = self.frequencyForInterval(interval)
        let semitone = self.semitoneForInterval(interval)
        let octave = self.octaveForInterval(interval)

        return .init(semitone, octave: octave, frequency: frequency)
    }

    static func noteForFrequency(_ frequency: Float) -> Note {
        let interval = self.intervalForFrequency(frequency)
        return self.noteForInterval(interval).with(frequency: frequency)
    }
}

private extension Note {
    func with(frequency: Float) -> Self {
        .init(self.semitone, octave: self.octave, frequency: frequency)
    }
}
