// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI
import TestKit

struct TestCoordinator<Content>: View where Content: View {
    let content: () -> Content

    private var launchEnvironment: LaunchEnvironment {
        ProcessInfo.processInfo.launchEnvironment
    }

    private var preferredColorScheme: ColorScheme? {
        switch self.launchEnvironment.colorScheme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }

    var body: some View {
        if let appStoreScreenshot = self.launchEnvironment.appStoreScreenshot {
            Group {
                switch appStoreScreenshot {
                case .first:
                    TunerView(
                        tuner: .mockedDetecting(note: .standard),
                        selectedNote: .standard
                    )
                case .second:
                    TunerView(
                        tuner: .mockedDetecting(frequency: 450),
                        selectedNote: .standard
                    )
                case .third:
                    TunerView(
                        tuner: .mockedDetecting(note: .gSharp(4)),
                        selectedNote: .standard,
                        displayMode: .constant(.both)
                    )
                case .fourth:
                    TunerView(
                        tuner: .mockedDetecting(),
                        selectedNote: .standard
                    ).sheet(isPresented: .constant(true)) {
                        NotePicker(selection: .constant(.g(3)))
                            .preferredColorScheme(self.preferredColorScheme)
                    }
                }
            }
            .preferredColorScheme(self.preferredColorScheme)
        } else {
            // For all oother tests, pass in the launch environment
            self.content()
                .environment(\.launchEnvironment, self.launchEnvironment)
        }
    }
}

// MARK: - Supporting Types

private enum AppStoreScreenshot: Int {
    case first
    case second
    case third
    case fourth
}

private extension LaunchEnvironment {
    var appStoreScreenshot: AppStoreScreenshot? {
        if let appStoreScreenshotIndex = self.appStoreScreenshotIndex {
            return AppStoreScreenshot(rawValue: appStoreScreenshotIndex)
        } else {
            return nil
        }
    }
}
