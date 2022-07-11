// Copyright © 2022 Brian Drelling. All rights reserved.

import AudioKit

public final class AudioDeviceManager {
    public static let shared = AudioDeviceManager()

    private init() {}

    public var inputDevices: [Device] {
        AudioEngine.inputDevices.compactMap { $0 }
    }
    
#if !os(macOS)
    public func setInputDevice(to device: Device) {
        do {
            try AudioEngine.setInputDevice(device)
        } catch {
            print(error.localizedDescription)
        }
    }
#endif
}
