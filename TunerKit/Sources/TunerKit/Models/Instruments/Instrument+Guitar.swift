// Copyright © 2022 Brian Drelling. All rights reserved.

public extension Instrument {
    static let guitar: Self = .init(
        name: "Guitar",
        numberOfStrings: 6,
        origins: [
            "Spain (acoustic)",
            "US (electric)",
        ],
        standardTuning: .e(2), .a(2), .d(3), .g(3), .b(3), .e(4),
        alternativeTunings: [
            .init("Drop D", notes: .d(2), .a(2), .d(3), .g(3), .b(3), .e(4)),
            .init("Open D", notes: .d(2), .a(2), .d(3), .fSharp(3), .a(3), .d(4)),
            .init("Open G", notes: .d(2), .g(2), .d(2), .g(2), .b(3), .d(4)),
            .init("Open A", notes: .e(2), .a(2), .e(3), .a(3), .cSharp(3), .e(4)),
            .init("Lute", notes: .e(2), .a(2), .d(3), .fSharp(3), .b(3), .e(4)),
            .init("Irish", notes: .d(2), .a(2), .d(3), .g(3), .a(3), .d(4)),
            .init("Nashville", notes: .e(3), .a(3), .d(4), .g(4), .b(3), .e(4)),
        ]
    )
}
