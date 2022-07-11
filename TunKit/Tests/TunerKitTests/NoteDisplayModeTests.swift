// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit
import TunerKit
import XCTest

final class NoteDisplayModeTests: XCTestCase {
    func testNoteDisplayModeForStandardNote() {
        let note: Note = .middleC

        XCTAssertEqual(note.name(for: .both), "C4")
        XCTAssertEqual(note.name(for: .sharps), "C4")
        XCTAssertEqual(note.name(for: .flats), "C4")

        let semitone: Semitone = .c

        XCTAssertEqual(semitone.name(for: .both), "C")
        XCTAssertEqual(semitone.name(for: .sharps), "C")
        XCTAssertEqual(semitone.name(for: .flats), "C")
    }

    func testNoteDisplayModeForSharpNote() {
        let note: Note = .cSharp(4)

        XCTAssertEqual(note.name(for: .both), "C♯4 / D♭4")
        XCTAssertEqual(note.name(for: .sharps), "C♯4")
        XCTAssertEqual(note.name(for: .flats), "D♭4")

        let semitone: Semitone = .cSharp

        XCTAssertEqual(semitone.name(for: .both), "C♯ / D♭")
        XCTAssertEqual(semitone.name(for: .sharps), "C♯")
        XCTAssertEqual(semitone.name(for: .flats), "D♭")
    }
}
