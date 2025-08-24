//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
//
//    import Combine
//
//    /// Centralized application state shared across all modules.
//    ///
//    /// Tracks the current user's authentication state and exposes
//    /// reactive properties for SwiftUI views to update automatically.
//    ///
//    /// Usage:
//    /// ```swift
//    /// @StateObject var appState = AppState()
//    /// .environmentObject(appState)
//    /// ```
//    ///
//    /// Modules can access the current user ID or check login status via
//    /// `@EnvironmentObject var appState: AppState`.
//    public final class AppState: ObservableObject {
//        public static let shared = AppState()
//
//        /// The current logged-in user's unique identifier.
//        ///
//        /// - `nil` if no user is logged in.
//        /// - Set this value to log in a user.
//        /// - Set to `nil` to log out.
//        @Published public var userID: String?
//
//        /// Indicates whether a user is currently logged in.
//        ///
//        /// Computed from `userID`. Returns `true` if `userID` is non-nil,
//        /// `false` otherwise.
//        public var isLoggedIn: Bool { userID != nil }
//
//        /// Default initializer.
//        ///
//        /// Creates an `AppState` instance with no logged-in user.
//        public init() {}
//    }
