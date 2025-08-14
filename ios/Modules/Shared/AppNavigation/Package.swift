// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppNavigation",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AppNavigationAPI", targets: ["AppNavigationAPI"]),
        .library(
            name: "AppNavigation", targets: ["AppNavigation"]),
        .library(name: "AppNavigationMocks", targets: ["AppNavigationMocks"])
    ],
    targets: [
        .target(
            name: "AppNavigationAPI",
            dependencies: [],
            path: "Sources/API"),
        .target(
            name: "AppNavigation",
            dependencies: [
                "AppNavigationAPI"
            ],
            path: "Sources/Impl/"),
        .target(
            name: "AppNavigationMocks",
            dependencies: [
                "AppNavigationAPI"
            ],
            path: "Sources/Mocks/"),
        .testTarget(
            name: "AppNavigationTests",
            dependencies: ["AppNavigation"])
    ]
)
