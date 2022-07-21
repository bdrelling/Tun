// Copyright © 2022 Brian Drelling. All rights reserved.

import TestKit
import XCTest

class AppStoreScreenshotTests: XCTestCase {
    public static let numberOfAppStoreScreenshots = 4

    func testTakeAppStoreScreenshots() throws {
        var attachments: [XCTAttachment] = []
        for index in 0 ..< Self.numberOfAppStoreScreenshots {
            let app = XCUIApplication()
            app.launchForTesting(colorScheme: .dark, appStoreScreenshotIndex: index)

            let attachment = app.takeAppStoreScreenshot(index: index)
            attachments.append(attachment)
        }

        attachments.forEach { add($0) }
    }
}

// MARK: - Extensions

private extension XCUIApplication {
    func launchForTesting(with launchEnvironment: LaunchEnvironment? = nil) {
        // Apend the flag that will let us know that the app is running UI tests.
        // We detect this manually in TunApp+Constants.
        self.launchArguments.append("-ui_testing")

        if let launchEnvironment = launchEnvironment {
            self.launchEnvironment = launchEnvironment.toStringDictionary()
        }

        self.launch()
    }

    func launchForTesting(colorScheme: LaunchEnvironment.ColorScheme? = nil, appStoreScreenshotIndex index: Int) {
        self.launchForTesting(with: .init(colorScheme: colorScheme, appStoreScreenshotIndex: index))
    }

    /// Takes a screenshot and saves it as an attachment to the test, regardless of success or failure.
    /// The typical use case for this is when collecting automatic app store screenshots
    /// - Parameter name: The name of the screenshot. If an extension is included, it will override the default of `.png`.
    /// - Returns: An `XCTAttachment` ready to be added to the `XCTestCase`.
    func takeAppStoreScreenshot(named name: String? = nil) -> XCTAttachment {
        let screenshot = self.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways

        return attachment
    }

    func takeAppStoreScreenshot(index: Int) -> XCTAttachment {
        self.takeAppStoreScreenshot(named: "AppStoreScreenshot_\(String(format: "%02d", index))")
    }
}
