//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import SwiftUI
import AppNavigationAPI

final class NavigationRegistry: NavigationRegistryProtocol {
    private var builders: [ObjectIdentifier: (Any) -> AnyView] = [:]

    func registerView<Data>(_ type: Data.Type, builder: @escaping (Data) -> AnyView) where Data: NavigationData {
        let key = ObjectIdentifier(type)
        builders[key] = { anyData in
            guard let data = anyData as? Data else {
                return AnyView(EmptyView()) }
            return builder(data)
        }
    }
    
    func resolveView<Data: NavigationData>(data: Data) -> AnyView? where Data: NavigationData {
        let key = ObjectIdentifier(type(of: data))
        return builders[key]?(data)
    }
}

public struct NavigationRegistryFactoryImpl: NavigationRegistryFactory {
    public static func make() -> NavigationRegistryProtocol {
        NavigationRegistry()
    }
}
