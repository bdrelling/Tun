// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit
import XCTest

final class MusicMathTests: XCTestCase, MusicMathCalculating {
    // MARK: Frequency

    func testCalculatingFrequencyForNoteAndOctave() {
        XCTAssertEqual(MusicMath.frequencyForNote(.a, octave: 4), 440.0)
        XCTAssertEqual(MusicMath.frequencyForNote(.c, octave: 4), 261.63)

        XCTAssertEqual(MusicMath.frequencyForNote(.e, octave: 2), 82.41)
        XCTAssertEqual(MusicMath.frequencyForNote(.a, octave: 2), 110.0)
        XCTAssertEqual(MusicMath.frequencyForNote(.d, octave: 3), 146.83)
        XCTAssertEqual(MusicMath.frequencyForNote(.g, octave: 3), 196.0)
        XCTAssertEqual(MusicMath.frequencyForNote(.b, octave: 3), 246.94)
        XCTAssertEqual(MusicMath.frequencyForNote(.e, octave: 4), 329.63)
    }

    // MARK: Semitone

    func testCalculatingSemitoneForFrequency() {
        XCTAssertEqual(MusicMath.semitoneForFrequency(440.0), .a)
        XCTAssertEqual(MusicMath.semitoneForFrequency(261.6), .c)

        XCTAssertEqual(MusicMath.semitoneForFrequency(82.4), .e)
        XCTAssertEqual(MusicMath.semitoneForFrequency(110.0), .a)
        XCTAssertEqual(MusicMath.semitoneForFrequency(146.8), .d)
        XCTAssertEqual(MusicMath.semitoneForFrequency(196.0), .g)
        XCTAssertEqual(MusicMath.semitoneForFrequency(246.9), .b)
        XCTAssertEqual(MusicMath.semitoneForFrequency(329.6), .e)
    }

    // MARK: Octave

    func testCalculatingOctaveForFrequency() {
        XCTAssertEqual(MusicMath.octaveForFrequency(440.0), 4)
        XCTAssertEqual(MusicMath.octaveForFrequency(261.6), 4)

        XCTAssertEqual(MusicMath.octaveForFrequency(82.4), 2)
        XCTAssertEqual(MusicMath.octaveForFrequency(110.0), 2)
        XCTAssertEqual(MusicMath.octaveForFrequency(146.8), 3)
        XCTAssertEqual(MusicMath.octaveForFrequency(196.0), 3)
        XCTAssertEqual(MusicMath.octaveForFrequency(246.9), 3)
        XCTAssertEqual(MusicMath.octaveForFrequency(329.6), 4)
    }

    // MARK: Note

    func testCalculatingNoteForFrequency() {
        XCTAssertEqual(MusicMath.noteForFrequency(440.0), .a(4))
        XCTAssertEqual(MusicMath.noteForFrequency(261.6), .c(4))

        XCTAssertEqual(MusicMath.noteForFrequency(82.4), .e(2))
        XCTAssertEqual(MusicMath.noteForFrequency(110.0), .a(2))
        XCTAssertEqual(MusicMath.noteForFrequency(146.8), .d(3))
        XCTAssertEqual(MusicMath.noteForFrequency(196.0), .g(3))
        XCTAssertEqual(MusicMath.noteForFrequency(246.9), .b(3))
        XCTAssertEqual(MusicMath.noteForFrequency(329.6), .e(4))
    }

    // MARK: Theoreticall

    func testFirstNegativeOctave() {
        let frequencies = Semitone.allCases.map { Note($0, octave: -1) }.map(\.frequency)

        XCTAssertEqual(frequencies, [
            8.18,
            8.66,
            9.18,
            9.72,
            10.30,
            10.91,
            11.56,
            12.25,
            12.98,
            13.75,
            14.57,
            15.43,
        ])
    }

    func testNinthOctave() {
        let frequencies = Semitone.allCases.map { Note($0, octave: 9) }.map(\.frequency)

        XCTAssertEqual(frequencies, [
            8372.02,
            8869.85,
            9397.27,
            9956.06,
            10548.08,
            11175.30,
            11839.82,
            12543.86,
            13289.75,
            14080.00,
            14917.24,
            15804.26,
        ])
    }

    // This test ensures that bounded index checks are respected and that outrageously high or low octaves
    // don't throw any errors. These sorts of octaves are usually picked up from microphone interference
    // or other inaudible noises.
    func testTheoreticalOctaves() {
        let lowNotes = Semitone.allCases.map { Note($0, octave: -100) }
        let highNotes = Semitone.allCases.map { Note($0, octave: 100) }

        XCTAssertEqual(lowNotes.count, Semitone.count)
        XCTAssertEqual(lowNotes.map(\.note), Semitone.allCases)

        XCTAssertEqual(highNotes.count, Semitone.count)
        XCTAssertEqual(highNotes.map(\.note), Semitone.allCases)
    }
}
