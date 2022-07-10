// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI

struct TunerScreen: View {
    var body: some View {
        NavigationView {
            TunerView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: Text("Wow")) {
                            Image(systemName: "gearshape")
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .configureNavigation(.transparent())
        }
    }

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

// MARK: - Previews

struct TunerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TunerScreen()
            .previewMatrix(.currentDevice)
    }
}
