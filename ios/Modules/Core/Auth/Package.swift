// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Auth",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AuthAPI", targets: ["AuthAPI"]),
        .library(name: "Auth", targets: ["Auth"]),
        .library(name: "AuthMocks", targets: ["AuthMocks"])

    ],
    dependencies: [
        .package(name: "AppLogging", path: "../../Shared/AppLogging"),
        .package(name: "AppNavigation", path: "../../Shared/AppNavigation"),
        .package(name: "DIModule", path: "../../Shared/DIModule"),
        .package(name: "UIComponents", path: "../../Shared/UIComponents"),
        .package(name: "BTRestClient", path: "../../Shared/BTRestClient")
    ],
    targets: [
        .target(
            name: "AuthAPI",
            dependencies: [
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/API"),
        .target(
            name: "Auth",
            dependencies: [
                "AuthAPI",
                "AppLogging",
                "DIModule",
                "UIComponents",
                "BTRestClient",
                .product(name: "AppNavigationAPI", package: "AppNavigation")
            ],
            path: "Sources/Impl/"),
        .target(
            name: "AuthMocks",
            dependencies: [
                "AuthAPI"
            ],
            path: "Sources/Mocks/"),
        .testTarget(
            name: "AuthTests",
            dependencies: ["Auth",
                           "DIModule",
                           .product(name: "AppNavigationMocks", package: "AppNavigation"),
                           .product(name: "AppLoggingMocks", package: "AppLogging"),
                           .product(name: "BTRestClientMocks", package: "BTRestClient")
                          ],
            path: "Tests/AuthTests")
    ]
)
