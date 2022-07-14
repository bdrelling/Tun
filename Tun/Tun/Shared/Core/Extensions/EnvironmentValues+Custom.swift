import SwiftUI

// MARK: - App Settings

private struct AppSettingsKey: EnvironmentKey {
    static let defaultValue: AppSettings = .default
}

extension EnvironmentValues {
  var appSettings: AppSettings {
    get { self[AppSettingsKey.self] }
    set { self[AppSettingsKey.self] = newValue }
  }
}
