// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BTMyBudget",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "BTMyBudgetAPI", targets: ["BTMyBudgetAPI"]),
        .library(name: "BTMyBudget", targets: ["BTMyBudget"]),
        
    ],
    dependencies: [
        .package(name: "AppLogging", path: "../../Shared/AppLogging"),
        .package(name: "AppNavigation", path: "../../Shared/AppNavigation"),
        .package(name: "DIModule", path: "../../Shared/DIModule"),
        .package(name: "UIComponents", path: "../../Shared/UIComponents")
    ],
    targets: [
        .target(
            name: "BTMyBudgetAPI",
            dependencies: [
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/API"),
        .target(
            name: "BTMyBudget",
            dependencies: [
                "BTMyBudgetAPI",
                "AppLogging",
                "DIModule",
                "UIComponents",
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/Impl/"),
        .testTarget(
            name: "BTMyBudgetTests",
            dependencies: ["BTMyBudget",
                           "DIModule",
                           .product(name: "AppNavigationMocks", package: "AppNavigation"),
                           .product(name: "AppLoggingMocks", package: "AppLogging")
                          ],
            path: "Tests/BTMyBudgetTests")
    ]
)
