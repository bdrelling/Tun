// Copyright © 2022 Brian Drelling. All rights reserved.

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    private var menuController: MenuController?

    override func buildMenu(with builder: UIMenuBuilder) {
        if builder.system == .main {
            self.menuController = MenuController(with: builder)
        }
    }
}

/*

 Add to App like so:

 @main
 struct SynthApp: App {
     /// The `AppDelegate` required by this application.
     @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
 }

 */
