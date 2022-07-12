//
//  TunUITests.swift
//  TunUITests
//
//  Created by Brian Drelling on 7/11/22.
//

import XCTest

final class LaunchPerformanceUITests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        false
    }
    
    func testLaunchPerformance() async throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
