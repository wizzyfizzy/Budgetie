// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "OnboardingAPI", targets: ["OnboardingAPI"]),
        .library(name: "Onboarding", targets: ["Onboarding"]),
        .library(name: "OnboardingMocks", targets: ["OnboardingMocks"])
    ],
    dependencies: [
        .package(name: "AppLogging", path: "../../Shared/AppLogging"),
        .package(name: "AppNavigation", path: "../../Shared/AppNavigation"),
        .package(name: "DIModule", path: "../../Shared/DIModule"),
        .package(name: "UIComponents", path: "../../Shared/UIComponents")
    ],
    targets: [
        .target(
            name: "OnboardingAPI",
            dependencies: [
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/API"),
        .target(
            name: "Onboarding",
            dependencies: [
                "OnboardingAPI",
                "AppLogging",
                "DIModule",
                "UIComponents",
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/Impl/"),
        .target(
            name: "OnboardingMocks",
            dependencies: [
                "OnboardingAPI"
            ],
            path: "Sources/Mocks/"),
        .testTarget(
            name: "OnboardingTests",
            dependencies: ["Onboarding",
                           "DIModule",
                           .product(name: "AppNavigationMocks", package: "AppNavigation"),
                           .product(name: "AppLoggingMocks", package: "AppLogging")
            ],
            path: "Tests/OnboardingTests"
        )
    ]
)
