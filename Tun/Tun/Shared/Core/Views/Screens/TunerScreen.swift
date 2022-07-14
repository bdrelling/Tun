// Copyright © 2022 Brian Drelling. All rights reserved.

import SwiftUI
import TunerKit

struct TunerScreen: View {
    @EnvironmentObject var appSettings: AppSettings
    
    private let tuner: Tuner
    
    var body: some View {
        NavigationView {
            TunerView(
                tuner: self.tuner,
                displayMode: self.$appSettings.noteDisplayMode
            )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape")
                                .opacity(0.65)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .configureNavigation(.transparent())
        }
        .navigationViewStyle(.stack)
    }
    
    init(audioSettings: AudioSettings) {
        self.tuner = .init(audioSettings: audioSettings)
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

// MARK: - Previews

struct TunerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TunerScreen(audioSettings: .mocked)
            .environmentObject(AppSettings.mocked)
            .previewMatrix(.currentDevice)
    }
}
