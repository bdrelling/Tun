// Copyright © 2022 Brian Drelling. All rights reserved.

public enum NoteDisplayMode: CaseIterable {
    case sharps
    case flats
    case both
}

// MARK: - Convenience

public extension NoteDisplayMode {
    static let `default`: Self = .sharps
}
