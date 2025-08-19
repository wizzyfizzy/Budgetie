// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BTProfile",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "BTProfileAPI", targets: ["BTProfileAPI"]),
        .library(name: "BTProfile", targets: ["BTProfile"])
        
    ],
    dependencies: [
        .package(name: "AppLogging", path: "../../Shared/AppLogging"),
        .package(name: "AppNavigation", path: "../../Shared/AppNavigation"),
        .package(name: "DIModule", path: "../../Shared/DIModule"),
        .package(name: "UIComponents", path: "../../Shared/UIComponents")
    ],
    targets: [
        .target(
            name: "BTProfileAPI",
            dependencies: [
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/API"),
        .target(
            name: "BTProfile",
            dependencies: [
                "BTProfileAPI",
                "AppLogging",
                "DIModule",
                "UIComponents",
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/Impl/"),
        .testTarget(
            name: "BTProfileTests",
            dependencies: ["BTProfile",
                           "DIModule",
                           .product(name: "AppNavigationMocks", package: "AppNavigation"),
                           .product(name: "AppLoggingMocks", package: "AppLogging")
                          ],
            path: "Tests/BTProfileTests")
    ]
)
