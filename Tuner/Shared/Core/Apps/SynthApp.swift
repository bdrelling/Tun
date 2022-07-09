// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

@main
struct SynthApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
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
