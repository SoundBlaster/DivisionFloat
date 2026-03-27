// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "DivisionFloat",
    products: [
        .library(name: "DivisionCore", targets: ["DivisionCore"]),
        .executable(name: "DivisionFloat", targets: ["DivisionFloat"]),
    ],
    targets: [
        .target(
            name: "DivisionCore"
        ),
        .executableTarget(
            name: "DivisionFloat",
            dependencies: ["DivisionCore"]
        ),
        .testTarget(
            name: "DivisionFloatTests",
            dependencies: ["DivisionCore"]
        ),
    ]
)
