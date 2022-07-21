// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        TunerScreen(audioSettings: self.appSettings.audio)
    }
}

// MARK: - Previews

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
