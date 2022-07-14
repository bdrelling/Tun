// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "TünKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "InstrumentKit", targets: ["InstrumentKit"]),
        .library(name: "MusicKit", targets: ["MusicKit"]),
        .library(name: "TestKit", targets: ["TestKit"]),
        .library(name: "TunerKit", targets: ["TunerKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AudioKit/AudioKit", .upToNextMajor(from: "5.4.4")),
        .package(url: "https://github.com/AudioKit/AudioKitEX", .upToNextMajor(from: "5.4.1")),
        .package(url: "https://github.com/AudioKit/SoundpipeAudioKit", .upToNextMajor(from: "5.4.3")),
        .package(url: "https://github.com/swift-kipple/Core", .upToNextMinor(from: "0.9.2")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "AudioKitAdapter",
            dependencies: [
                .product(name: "AudioKit", package: "AudioKit"),
                .product(name: "AudioKitEX", package: "AudioKit"),
                .product(name: "SoundpipeAudioKit", package: "AudioKit"),
            ],
            exclude: [
                "Examples",
            ]
        ),
        .target(
            name: "InstrumentKit",
            dependencies: [
                .target(name: "MusicKit"),
            ]
        ),
        .target(
            name: "MusicKit",
            dependencies: []
        ),
        .target(
            name: "TestKit",
            dependencies: []
        ),
        .target(
            name: "TunerKit",
            dependencies: [
                .product(name: "KippleCore", package: "Core"),
                .target(name: "AudioKitAdapter"),
                .target(name: "InstrumentKit"),
                .target(name: "MusicKit"),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "InstrumentKitTests",
            dependencies: [
                "InstrumentKit"
            ]
        ),
        .testTarget(
            name: "MusicKitTests",
            dependencies: [
                "MusicKit"
            ]
        ),
        .testTarget(
            name: "TunerKitTests",
            dependencies: [
                "TunerKit"
            ]
        ),
    ]
)
