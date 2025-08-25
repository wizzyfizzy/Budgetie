//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import Foundation
@testable import BTRestClientAPI

/// Mock HTTP client with stub & verify support
public final class BTRestClientMocks: HTTPClient {
    
    // MARK: - Call record
    public struct Call<E: APIErrorMapping> {
        let path: HTTPPath
        let method: HTTPMethod
        let body: [String: Any]?
        let headers: [String: String]?
        let errorMapping: E.Type?
    }
    
    public private(set) var calls: [Any] = [] // store erased calls
    
    // MARK: - Stub provider
    public var stub: ((HTTPPath, HTTPMethod, [String: Any]?, [String: String]?) async throws -> Any)?
    
    public init() {}
    
    // MARK: - HTTPClient
    public func request<T: Decodable, E: APIErrorMapping>(
        path: HTTPPath,
        method: HTTPMethod,
        body: [String: Any]? = nil,
        headers: [String: String]? = nil,
        errorMapping: E.Type? = nil
    ) async throws -> T {
        
        // Record call
        calls.append(Call(path: path, method: method, body: body, headers: headers, errorMapping: errorMapping))
        
        // Return stubbed result
        if let stub = stub {
            let result = try await stub(path, method, body, headers)
            guard let typedResult = result as? T else {
                fatalError("Stub returned wrong type. Expected \(T.self) but got \(type(of: result))")
            }
            return typedResult
        }
        
        fatalError("Stub not set for BTRestClientMocks")
    }
    // MARK: - Verification helpers
    public func verifyCalled(
        path: HTTPPath,
        method: HTTPMethod,
        body: [String: Any]? = nil
    ) -> Bool {
        return calls.contains { anyCall in
            // erase generic type for comparison
            if let call = anyCall as? AnyCall {
                return call.path == path &&
                call.method == method &&
                (body == nil || NSDictionary(dictionary: call.body ?? [:]).isEqual(to: body!))
            }
            return false
        }
    }
    
    // Helper type-erased wrapper for stored calls
    private struct AnyCall {
        let path: HTTPPath
        let method: HTTPMethod
        let body: [String: Any]?
        let headers: [String: String]?
    }
}
