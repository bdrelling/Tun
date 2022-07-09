// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKit

final class AudioDeviceManager {
    static let shared = AudioDeviceManager()

    private init() {}

    var inputDevices: [Device] {
        AudioEngine.inputDevices.compactMap { $0 }
    }

    #if !os(macOS)
        func setInputDevice(to device: Device) {
            do {
                try AudioEngine.setInputDevice(device)
            } catch {
                print(error.localizedDescription)
            }
        }
    #endif
}
