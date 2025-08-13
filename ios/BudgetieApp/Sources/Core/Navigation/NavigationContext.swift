//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import SwiftUI
import AppNavigationAPI

/// Holds navigation state (`path` for pushes, `sheetView` for modals) and provides handlers to update it.
/// Used inside SwiftUI views via `@ObservedObject` or injected into Use Cases.
public final class NavigationContext: ObservableObject {
    @Published var path: [AnyViewWrapper] = []
    @Published var sheetView: AnyViewWrapper?
   
    let registry: NavigationRegistryProtocol

    public init(registry: NavigationRegistryProtocol) {
        self.registry = registry
    }
    public var navigationHandler: (NavigationData, NavigationType) -> Void {
        { [weak self] data, type in
            guard let self,
                  let view = self.registry.resolveView(data: data) else { return }

            DispatchQueue.main.async {
                let wrapper = AnyViewWrapper(view: view)
                switch type {
                case .push:
                    self.path.append(wrapper)
                case .sheet:
                    self.sheetView = wrapper
                }
            }
        }
    }
}
