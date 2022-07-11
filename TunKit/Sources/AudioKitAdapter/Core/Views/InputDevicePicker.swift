//// Copyright © 2022 Brian Drelling. All rights reserved.
//
//#if canImport(SwiftUI)
//
//    import AudioKit
//    import SwiftUI
//
//    public struct InputDevicePicker: View {
//        @State private var device: Device
//
//        public var body: some View {
//            Picker("Input: \(device.deviceID)", selection: $device) {
//                ForEach(AudioDeviceManager.shared.inputDevices, id: \.self) {
//                    Text($0.deviceID)
//                }
//            }
//            .pickerStyle(MenuPickerStyle())
//            .onChange(of: device, perform: AudioDeviceManager.shared.setInputDevice)
//        }
//    }
//
//#endif
