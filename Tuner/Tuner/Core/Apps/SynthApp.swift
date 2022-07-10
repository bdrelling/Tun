// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

@main
struct SynthApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                // This will override the entire application with Dark Mode settings.
                // This is temporarily in place until support for both modes is properly implemented.
                .preferredColorScheme(.dark)
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
