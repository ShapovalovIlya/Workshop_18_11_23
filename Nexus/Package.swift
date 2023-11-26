// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Nexus",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(name: "Nexus", targets: ["Nexus"]),
        .library(name: "Redux", targets: ["Redux"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "Endpoint", targets: ["Endpoint"]),
    ],
    targets: [
        .target(name: "Nexus"),
        .target(name: "Redux"),
        .target(name: "Endpoint"),
        .target(name: "Networking"),
        .testTarget(
            name: "NexusTests",
            dependencies: ["Nexus"]),
        .testTarget(name: "EndpointTests", dependencies: ["Endpoint"]),
    ]
)
