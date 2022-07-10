// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

struct RootView: View {
    var body: some View {
        #if os(macOS)
            TunerView()
        #else
            TunerScreen()
        #endif
    }
}

// MARK: - Previews

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
