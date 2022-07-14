// Copyright © 2022 Brian Drelling. All rights reserved.

public enum NoteDisplayMode: String, CaseIterable {
    case sharps = "Sharps"
    case flats = "Flats"
    case both = "Sharps / Flats"
}

// MARK: - Convenience

public extension NoteDisplayMode {
    static let `default`: Self = .sharps
}

// MARK: - Extensions

extension NoteDisplayMode: Identifiable {
    public var id: String {
        self.rawValue
    }
}

public extension NoteDisplayMode {
    var symbol: String {
        switch self {
        case .sharps:
            return "♯"
        case .flats:
            return "♭"
        case .both:
            return "♯/♭"
        }
    }
}
