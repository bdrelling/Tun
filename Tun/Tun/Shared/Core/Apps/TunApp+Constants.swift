// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension TunApp {
    static var isRunningTests: Bool {
        self.isRunningUnitTests || self.isRunningUITests
    }
    
    /// Whether or not the app is running unit tests.
    static var isRunningUnitTests: Bool {
        NSClassFromString("XCTestCase") != nil
    }
    
    /// Whether or not the app is running UI tests.
    static var isRunningUITests: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui_testing")
    }
}
