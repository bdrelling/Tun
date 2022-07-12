import TestKit
import XCTest

class TunUITests: XCTestCase {
    func testTakeScreenshotOfMainWindow() throws {
        let app = self.launchApp(with: .init(isDetectingAudio: true))
        
        let screenshot = app.takeAppStoreScreenhot(named: "AppStoreScreenshot")
        
        add(screenshot)
    }
    
    private func launchApp(with launchEnvironment: LaunchEnvironment) -> XCUIApplication {
        let app = XCUIApplication()
        app.launchEnvironment = launchEnvironment.toStringDictionary()
        app.launch()
        
        return app
    }
}

private extension XCUIApplication {
    /// Takes a screenshot and saves it as an attachment to the test, regardless of success or failure.
    /// The typical use case for this is when collecting automatic app store screenshots
    /// - Parameter name: The name of the screenshot. If an extension is included, it will override the default of `.png`.
    /// - Returns: An `XCTAttachment` ready to be added to the `XCTestCase`.
    func takeAppStoreScreenhot(named name: String? = nil) -> XCTAttachment {
        let screenshot = self.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        
        return attachment
    }
}
