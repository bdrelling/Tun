// Copyright © 2022 Brian Drelling. All rights reserved.

import MusicKit
import TestKit

extension LaunchEnvironment {
    var selectedSemitone: Semitone? {
        if let selectedSemitone = self.selectedSemitoneValue {
            return .init(rawValue: selectedSemitone)
        } else {
            return nil
        }
    }

    var selectedOctave: Octave? {
        if let selectedOctave = self.selectedOctaveValue {
            return .init(rawValue: selectedOctave)
        } else {
            return nil
        }
    }
}
