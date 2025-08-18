// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BTTransactions",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "BTTransactionsAPI", targets: ["BTTransactionsAPI"]),
        .library(name: "BTTransactions", targets: ["BTTransactions"]),
        
    ],
    dependencies: [
        .package(name: "AppLogging", path: "../../Shared/AppLogging"),
        .package(name: "AppNavigation", path: "../../Shared/AppNavigation"),
        .package(name: "DIModule", path: "../../Shared/DIModule"),
        .package(name: "UIComponents", path: "../../Shared/UIComponents")
    ],
    targets: [
        .target(
            name: "BTTransactionsAPI",
            dependencies: [
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/API"),
        .target(
            name: "BTTransactions",
            dependencies: [
                "BTTransactionsAPI",
                "AppLogging",
                "DIModule",
                "UIComponents",
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/Impl/"),
        .testTarget(
            name: "BTTransactionsTests",
            dependencies: ["BTTransactions",
                           "DIModule",
                           .product(name: "AppNavigationMocks", package: "AppNavigation"),
                           .product(name: "AppLoggingMocks", package: "AppLogging")
                          ],
            path: "Tests/BTTransactionsTests")
    ]
)
