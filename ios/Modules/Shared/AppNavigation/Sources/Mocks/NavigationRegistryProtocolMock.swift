//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import Foundation
import Combine
@testable import AppNavigationAPI
import SwiftUI

public final class NavigationRegistryProtocolMock: NavigationRegistryProtocol {

    public init() {}
    
    public final class Stub {
        public var resolveViewClosure: ((NavigationData) -> AnyView?)?
    }
    
    public final class Verify {
        public var registerViewExecute: [(Any.Type)] = []
        public var resolveViewExecute: [(NavigationData)] = []
        
    }
    
    public let stub = Stub()
    public let verify = Verify()
    
    public func registerView<Data: NavigationData>(_ type: Data.Type, builder: @escaping (Data) -> AnyView) {
        verify.registerViewExecute.append(type)
    }
    
    public func resolveView<Data: NavigationData>(data: Data) -> AnyView? {
        verify.resolveViewExecute.append(data)
        guard let value = stub.resolveViewClosure?(data) else {
            fatalError( "'\(#function)' function called but not stubbed before. File: \(#file)")
        }
        return value
    }
}
