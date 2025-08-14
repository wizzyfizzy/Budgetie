//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

/// A lightweight Dependency Injection Container to register and resolve instances across modules.
public protocol DIResolver {
    /// Registers a service using a factory closure (lazy initialization).
    /// - Parameters:
    ///   - type: The type of the service to register.
    ///   - factory: A closure that returns an instance of the service.
    func register<T>(_ type: T.Type, factory: @escaping (DIResolver) -> T)
    
    /// Registers a concrete instance directly.
    /// - Parameters:
    ///   - type: The type of the service to register.
    ///   - instance: The instance to be used.
    func register<T>(_ type: T.Type, instance: T)

    // MARK: - Resolver Implementation

    /// Resolves a dependency of the specified type by returning a previously registered instance
    /// or by invoking a registered factory to create one.
    /// - Parameter type: The type of the dependency to resolve. This is inferred automatically in most cases.
    /// - Returns: An instance of the requested type. If the dependency is not registered, the app will crash.
    func resolve<T>(_ type: T.Type) -> T
}
