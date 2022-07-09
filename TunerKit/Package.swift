// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "TunerKit",
    products: [
        .library(name: "MusicKit", targets: ["MusicKit"]),
        .library(name: "TunerKit", targets: ["TunerKit"]),
    ],
    dependencies: [],
    targets: [
        // Product Targets
        .target(
            name: "MusicKit",
            dependencies: []
        ),
        .target(
            name: "TunerKit",
            dependencies: [
                .target(name: "MusicKit"),
            ]
        ),
        // Test Targets
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
