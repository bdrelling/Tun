// Copyright © 2022 Brian Drelling. All rights reserved.

public enum NoteDisplayMode: CaseIterable {
    case both
    case flats
    case sharps
}

// MARK: - Convenience

public extension NoteDisplayMode {
    static let `default`: Self = .sharps
}
