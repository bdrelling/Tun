// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit

public struct Instrument: Equatable {
    private static let standardTuningName = "Standard"

    public let name: String
    public let numberOfStrings: Int
    public let description: String?
    public let origins: [String]
    public let alternativeNames: [String]
    public let standardTuning: Tuning
    public let alternativeTunings: [Tuning]

    public var tunings: [Tuning] {
        self.alternativeTunings
    }

    public init(
        name: String,
        numberOfStrings: Int,
        description: String? = nil,
        origins: [String] = [],
        alternativeNames: [String] = [],
        standardTuning notes: Note...,
        alternativeTunings: [Tuning] = []
    ) {
        self.name = name
        self.numberOfStrings = numberOfStrings
        self.description = description
        self.origins = origins
        self.alternativeNames = alternativeNames
        self.standardTuning = .init(Self.standardTuningName, notes: notes)
        self.alternativeTunings = alternativeTunings
    }
}
