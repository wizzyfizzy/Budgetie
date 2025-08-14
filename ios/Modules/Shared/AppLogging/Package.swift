// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppLogging",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AppLogging", targets: ["AppLogging"]),
        .library(name: "AppLoggingMocks", targets: ["AppLoggingMocks"])
    ],
    targets: [
        .target(
            name: "AppLogging",
            dependencies: [],
            path: "Sources/Impl"),
        .target(
            name: "AppLoggingMocks",
            dependencies: ["AppLogging"],
            path: "Sources/Mocks"),
        .testTarget(
            name: "AppLoggingTests",
            dependencies: [
                "AppLogging"
            ])
    ]
)
