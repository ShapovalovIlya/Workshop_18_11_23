// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Nexus",
    products: [
        .library(name: "Nexus", targets: ["Nexus"]),
        .library(name: "Redux", targets: ["Redux"]),
    ],
    targets: [
        .target(name: "Nexus"),
        .target(name: "Redux"),
        .testTarget(
            name: "NexusTests",
            dependencies: ["Nexus"]),
    ]
)
