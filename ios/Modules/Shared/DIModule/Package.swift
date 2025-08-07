// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DIModule",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "DIModuleAPI", targets: ["DIModuleAPI"]),
        .library(name: "DIModule", targets: ["DIModule"])
    ],
    targets: [
        .target(
            name: "DIModuleAPI",
            dependencies: [],
            path: "Sources/API"),
        .target(
            name: "DIModule",
            dependencies: [
                "DIModuleAPI"
            ],
            path: "Sources/Impl/"),
        .testTarget(
            name: "DIModuleTests",
            dependencies: [
                "DIModule",
                "DIModuleAPI"
            ])
    ]
)
