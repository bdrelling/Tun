// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKitAdapter
import SwiftUI
import TestKit

@main
struct TunApp: App {
    /// The current scene phase of the application. This value can be used to detect changes in app state.
    ///
    /// For more information, see [Apple Documentation](https://developer.apple.com/documentation/swiftui/scenephase).
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RootView()
                // This will override the entire application with Dark Mode settings.
                // This is temporarily in place until support for both modes is properly implemented.
                .preferredColorScheme(.dark)
                .environment(\.launchEnvironment, ProcessInfo.processInfo.launchEnvironment)
        }
        .onChange(of: self.scenePhase) { newScenePhase in
            switch newScenePhase {
            case .background:
                // The scene isn't currently visible in the UI.
                break
            case .inactive:
                // The scene is in the foreground but should pause its work.
                break
            case .active:
                // The scene is in the foreground and interactive.
                break
            @unknown default:
                break
            }
        }
    }

    init() {
        do {
            try AudioManager.shared.start()
        } catch {
            print(error.localizedDescription)
        }
    }
}
