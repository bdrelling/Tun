// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "TunKit",
    products: [
        .library(name: "InstrumentKit", targets: ["InstrumentKit"]),
        .library(name: "MusicKit", targets: ["MusicKit"]),
        .library(name: "TunerKit", targets: ["TunerKit"]),
    ],
    dependencies: [],
    targets: [
        // Product Targets
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
            name: "TunerKit",
            dependencies: [
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
