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
                        selectedNote: .standard,
                        tuner: .mockedDetecting(note: .standard)
                    )
                case .second:
                    TunerView(
                        selectedNote: .standard,
                        tuner: .mockedDetecting(frequency: 450)
                    )
                case .third:
                    TunerView(
                        selectedNote: .standard,
                        displayMode: .constant(.both),
                        tuner: .mockedDetecting(note: .gSharp(4))
                    )
                case .fourth:
                    TunerView(
                        selectedNote: .standard,
                        tuner: .mockedDetecting()
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

fileprivate enum AppStoreScreenshot: Int {
    case first
    case second
    case third
    case fourth
}

fileprivate extension LaunchEnvironment {
    var appStoreScreenshot: AppStoreScreenshot? {
        if let appStoreScreenshotIndex = self.appStoreScreenshotIndex {
            return AppStoreScreenshot(rawValue: appStoreScreenshotIndex)
        } else {
            return nil
        }
    }
}
