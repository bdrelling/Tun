import SwiftUI
import TestKit

private struct LaunchEnvironmentKey: EnvironmentKey {
    static let defaultValue: LaunchEnvironment? = nil
}

extension EnvironmentValues {
  var launchEnvironment: LaunchEnvironment? {
    get { self[LaunchEnvironmentKey.self] }
    set { self[LaunchEnvironmentKey.self] = newValue }
  }
}
