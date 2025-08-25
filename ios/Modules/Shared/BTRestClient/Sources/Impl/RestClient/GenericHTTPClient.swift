//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//
import Foundation
import BTRestClientAPI

public struct GenericHTTPClient: HTTPClient {
    
    private let baseURL: String
    private let defaultHeaders: [String: String]
    // "http://127.0.0.1:8000/auth"
    // !! change it to Macs's IP when run on device
    //  private let baseURL = "http://192.168.1.42:5000/auth"
    public init(baseURL: String = "http://127.0.0.1:8000/auth",
                defaultHeaders: [String: String] = [HTTPHeaderKeyName.contentType.rawValue: kContentTypeApplicationJson]) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
    }

    public func request<T: Decodable, E: APIErrorMapping> (
        path: HTTPPath,
        method: HTTPMethod,
        body: [String: Any]? = nil,
        headers: [String: String]? = nil,
        errorMapping: E.Type? = nil
    ) async throws -> T {
        
        // Build URL
        guard let url = URL(string: "\(baseURL)\(path.rawValue)") else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Merge headers
        let mergedHeaders = defaultHeaders.merging(headers ?? [:]) { $1 }
        mergedHeaders.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Encode body
        if let body = body, method != .get && method != .delete {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } else if let body = body, method == .get || method == .delete {
            // append query parameters for GET/DELETE
            var components = URLComponents(string: "\(baseURL)\(path.rawValue)")
            components?.queryItems = body.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            if let urlWithQuery = components?.url {
                request.url = urlWithQuery
            }
        }

        // Perform request
        let (data, response) = try await URLSession.shared.data(for: request)

        // Handle HTTP errors
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
            if let errorMapping = errorMapping,
               let errorResp = try? JSONDecoder().decode([String: String].self, from: data),
               let code = errorResp["error"] {
                throw errorMapping.map(code)
            }
            throw GenericAPIError.from(data: data, statusCode: httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

// Generic error fallback
public struct GenericAPIError: Error, Decodable {
    let code: String?
    let message: String?

    static func from(data: Data, statusCode: Int) -> GenericAPIError {
        if let decoded = try? JSONDecoder().decode(GenericAPIError.self, from: data) {
            return decoded
        }
        return GenericAPIError(code: "\(statusCode)", message: "Unknown error")
    }
}
