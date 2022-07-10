// Copyright © 2022 Brian Drelling. All rights reserved.

#if !os(macOS)

    import AudioKit
    import SwiftUI

    struct InputDevicePicker: View {
        @State var device: Device

        var body: some View {
            Picker("Input: \(device.deviceID)", selection: $device) {
                ForEach(AudioDeviceManager.shared.inputDevices, id: \.self) {
                    Text($0.deviceID)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: device, perform: AudioDeviceManager.shared.setInputDevice)
        }
    }

#endif
