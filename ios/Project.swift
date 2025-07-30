import ProjectDescription

// MARK: - Packages

/// SPM Package definitions, these are either pulled from a remote source or used from the local filesystem
let projectPackages: [Package] = [
    .remote(url: "https://github.com/airbnb/lottie-spm", requirement: .exact("4.5.2")),
    // App
    .local(path: "Modules/Features/Auth"),
    .local(path: "Modules/Shared/UIComponents")
]

// MARK: - FileHeaderTemplate Extensions

extension FileHeaderTemplate {
    static let appHeader: FileHeaderTemplate = .string("""
    //
    //  Copyright © 2025 Budgetie
    //
    //  All rights reserved.
    //  No part of this software may be copied, modified, or distributed without prior written permission.
    //
    """)
}

// MARK: - Scripts
let swiftLintScript = TargetScript.pre(
    script: """
    if which swiftlint >/dev/null; then
    echo "SRCROOT is: ${SRCROOT}"
    cd "${SRCROOT}/../" || exit  # move up one folder to ios/
    swiftlint lint
    else
      echo "warning: SwiftLint not installed. Download from https://github.com/realm/SwiftLint"
    fi
    """,
    name: "SwiftLint"
)

// MARK: - Target Template Definitions

public extension Target {
    static func appTarget(name: String,
                          bundleId: String,
                          plist: String,
                          sources: String,
                          resources: String) -> Target {
        target(name: name,
               destinations: [.iPhone],
               product: .app,
               bundleId: bundleId,
               deploymentTargets: .iOS("16.0"),
               infoPlist: .init(stringLiteral: plist),
               sources: .init(stringLiteral: sources),
               resources: .init(stringLiteral: resources),
               scripts: [swiftLintScript])
    }
}

let project = Project(
    name: "Budgetie",
    organizationName: "krismatzi",
    packages: projectPackages,
    settings: .settings(base: ["ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES"]),
    targets: [
        Target.appTarget(name: "Budgetie",
                         bundleId: "com.krismatzi.BudgetieApp",
                         plist: "BudgetieApp/Info.plist",
                         sources: "BudgetieApp/Sources/**",
                         resources: "BudgetieApp/Resources/**")
    ],
    fileHeaderTemplate: .appHeader,
    resourceSynthesizers: []
)
