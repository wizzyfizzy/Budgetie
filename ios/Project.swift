import ProjectDescription

// MARK: - Packages

/// SPM Package definitions, these are either pulled from a remote source or used from the local filesystem
let projectPackages: [Package] = [
    .remote(url: "https://github.com/airbnb/lottie-spm", requirement: .exact("4.5.2")),
    // App
    .local(path: "Modules/Features/Auth"),
    .local(path: "Modules/Features/BTMyBudget"),
    .local(path: "Modules/Features/BTProfile"),
    .local(path: "Modules/Features/BTSubscriptions"),
    .local(path: "Modules/Features/BTTransactions"),
    .local(path: "Modules/Features/Onboarding"),
    .local(path: "Modules/Shared/AppLogging"),
    .local(path: "Modules/Shared/AppNavigation"),
    .local(path: "Modules/Shared/DIModule"),
    .local(path: "Modules/Shared/UIComponents")
]

// MARK: - Dependencies
let sharedMoldules: [TargetDependency] = [
    .package(product: "AppLogging"),
    .package(product: "AppNavigation"),
    .package(product: "DIModule"),
    .package(product: "UIComponents")
]

let coreMoldules: [TargetDependency] = [
]

let featureMoldules: [TargetDependency] = [
    .package(product: "Onboarding"),
    .package(product: "BTMyBudget"),
    .package(product: "BTProfile"),
    .package(product: "BTSubscriptions"),
    .package(product: "BTTransactions")
]

let projectDependencies = sharedMoldules + coreMoldules + featureMoldules

let projectTestDependencies: [TargetDependency] = [
    .target(name: "Budgetie"),
    .package(product: "AppNavigationMocks")
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

let sourceryScript = TargetScript.pre(
    script: """
    if which sourcery >/dev/null; then
      echo "🔧 Running Sourcery..."
      find Modules -type f -name .sourcery.yml | while read config; do
        echo "📄 Found config: $config"
        dir=$(dirname "$config")
        echo "🔁 Running Sourcery in $dir"
        sourcery --config "$config"
      done
    else
      echo "⚠️ Sourcery not installed. Run: brew install sourcery"
    fi
    """,
    name: "Sourcery"
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
               scripts: [swiftLintScript,
                         sourceryScript],
               dependencies: projectDependencies
        )
    }
    
    static func testTarget(name: String,
                           bundleId: String,
                           sources: String) -> Target {
        target(name: name,
               destinations: [.iPhone],
               product: .unitTests,
               bundleId: bundleId,
               deploymentTargets: .iOS("16.0"),
               sources: .init(stringLiteral: sources),
               scripts: [swiftLintScript],
               dependencies: projectTestDependencies
        )
    }
}

let project = Project(
    name: "Budgetie",
    organizationName: "krismatzi",
    packages: projectPackages,
    settings: .settings(base: ["ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES"]),
    targets: [
        // Main App Target
        Target.appTarget(name: "Budgetie",
                         bundleId: "com.budgetie.BudgetieApp",
                         plist: "BudgetieApp/Info.plist",
                         sources: "BudgetieApp/Sources/**",
                         resources: "BudgetieApp/Resources/**"),
        
        // Test target
        Target.testTarget(name: "BudgetieTests",
                          bundleId: "com.budgetie.BudgetieAppTest",
                          sources: "BudgetieAppTest/**")
    ],
    fileHeaderTemplate: .appHeader,
    resourceSynthesizers: []
)
