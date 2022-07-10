// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension SynthApp {
    /// Whether or not the app is running unit tests.
    static var isRunningTests: Bool {
        NSClassFromString("XCTestCase") != nil
    }
}
