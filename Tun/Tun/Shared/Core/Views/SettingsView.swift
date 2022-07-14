import SwiftUI
import TunerKit

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        List {
            Section("Audio Settings") {
                Toggle("Recording Enabled", isOn: self.$appSettings.audio.recordingEnabled)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Noise Threshold")
                        Spacer()
                        Text("\(self.appSettings.audio.noiseSensitivityThreshold, specifier: "%.2f")")
                    }
                    
                    Slider(
                        value: self.$appSettings.audio.noiseSensitivityThreshold,
                        in: AudioSettings.allowedNoiseSensitivityThresholds
                    )
                }
                .padding(.vertical, 4)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Accuracy Threshold")
                        Spacer()
                        Text("\(self.appSettings.audio.centAccuracyThreshold, specifier: "%.2f") cents")
                    }
                    
                    #warning("Make this an Integer step instead")
                    Slider(
                        value: self.$appSettings.audio.centAccuracyThreshold,
                        in: AudioSettings.allowedCentAccuracyThresholds
                    )
                }
                .padding(.vertical, 4)
                
                VStack(alignment: .leading) {
                    Text("Note Display Mode")
                    Picker("Note Display Mode", selection: self.$appSettings.noteDisplayMode) {
                        ForEach(NoteDisplayMode.allCases) { displayMode in
                            Text(displayMode.symbol)
                                .tag(displayMode)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.vertical, 4)
            }
        }
        .tint(Color.theme.closestTunerBackgroundColor)
    }
}

// MARK: - Previews

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppSettings.mocked)
            .previewMatrix(.sizeThatFits)
    }
}
