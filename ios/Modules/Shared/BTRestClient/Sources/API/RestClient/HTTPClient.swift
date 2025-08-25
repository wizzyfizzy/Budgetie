//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

/// A generic HTTP client protocol that defines a method for making network requests.
public protocol HTTPClient {
    /// Performs a network request and decodes the response into a `Decodable` type.
    /// - Parameters:
    ///   - path: The endpoint path (appended to baseURL)
    ///   - method: HTTP method (.get, .post, etc.)
    ///   - body: Optional request body for POST/PUT requests
    ///   - queryParams: Optional query parameters for GET/DELETE requests
    ///   - headers: Optional additional headers
    ///   - errorMapping: Optional mapping from API error codes to Swift errors
    func request<T: Decodable, E: APIErrorMapping>(
        path: HTTPPath,
        method: HTTPMethod,
        body: [String: Any]?,
        headers: [String: String]?,
        errorMapping: E.Type?
    ) async throws -> T
}
