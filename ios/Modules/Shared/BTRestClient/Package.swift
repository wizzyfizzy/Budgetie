// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BTRestClient",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "BTRestClientAPI", targets: ["BTRestClientAPI"]),
        .library(name: "BTRestClient", targets: ["BTRestClient"]),
        .library(name: "BTRestClientMocks", targets: ["BTRestClientMocks"])
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "BTRestClientAPI",
            dependencies: [ ],
            path: "Sources/API"),
        .target(
            name: "BTRestClient",
            dependencies: [
                "BTRestClientAPI"
            ],
            path: "Sources/Impl/"),
        .target(
            name: "BTRestClientMocks",
            dependencies: [
                "BTRestClientAPI"
            ],
            path: "Sources/Mocks/"),
        .testTarget(
            name: "BTRestClientTests",
            dependencies: ["BTRestClient"],
            path: "Tests/BTRestClientTests")
    ]
)
