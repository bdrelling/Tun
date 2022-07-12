// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKitAdapter
import KippleCore
import SwiftUI
import TestKit

@main
struct TunApp: App {
    /// The current scene phase of the application. This value can be used to detect changes in app state.
    ///
    /// For more information, see [Apple Documentation](https://developer.apple.com/documentation/swiftui/scenephase).
    @Environment(\.scenePhase) var scenePhase
    
    private var audioRecordingEnabled: Bool {
        !(Self.isRunningTests || Kipple.isRunningInXcodePreview)
    }
    
    private var networkingEnabled: Bool {
        !(Self.isRunningTests || Kipple.isRunningInXcodePreview)
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if Self.isRunningUITests {
                    TestCoordinator {
                        RootView()
                    }
                } else {
                    RootView()
                    // This will override the entire application with Dark Mode settings.
                    // This is temporarily in place until support for both modes is properly implemented.
                    .preferredColorScheme(.dark)
                }
            }
            .environment(\.audioRecordingEnabled, self.audioRecordingEnabled)
            .environment(\.networkingEnabled, self.networkingEnabled)
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
        guard self.audioRecordingEnabled else {
            return
        }
        
        do {
            try AudioManager.shared.start()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Supporting Types

private struct AudioRecordingEnabledKey: EnvironmentKey {
    static let defaultValue: Bool = true
}

extension EnvironmentValues {
  var audioRecordingEnabled: Bool {
    get { self[AudioRecordingEnabledKey.self] }
    set { self[AudioRecordingEnabledKey.self] = newValue }
  }
}

private struct NetworkingEnabledKey: EnvironmentKey {
    static let defaultValue: Bool = true
}

extension EnvironmentValues {
  var networkingEnabled: Bool {
    get { self[NetworkingEnabledKey.self] }
    set { self[NetworkingEnabledKey.self] = newValue }
  }
}
