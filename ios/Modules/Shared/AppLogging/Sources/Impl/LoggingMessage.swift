//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.
//

import Foundation

/// Supports custom logging with automatic obfuscation and formatting.
public struct LoggingMessage: ExpressibleByStringInterpolation, CustomStringConvertible {
    public var description: String
    
    public init(stringLiteral value: StringLiteralType) {
        self.description = value
    }

    public init(stringInterpolation: StringInterpolation) {
        self.description = stringInterpolation.result
    }

    public struct StringInterpolation: StringInterpolationProtocol {
        var result = ""

        public init(literalCapacity: Int, interpolationCount: Int) {
            result.reserveCapacity(literalCapacity)
        }

        public mutating func appendLiteral(_ literal: String) {
            result.append(literal)
        }

        public mutating func appendInterpolation(id: String) {
            result.append("{" + "\"id\": \"\(id)\"" + "}")
        }

        public mutating func appendInterpolation(json data: Data) {
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                let obfuscated = json.mapValues { _ in "********" }
                if let safeData = try? JSONSerialization.data(withJSONObject: obfuscated, options: .prettyPrinted),
                   let string = String(data: safeData, encoding: .utf8) {
                    result.append(string)
                    return
                }
            }
            result.append("INVALID_JSON")
        }

        public mutating func appendInterpolation(_ value: String, keep: Int) {
            let safe = String(value.prefix(keep)) + String(repeating: "*", count: max(0, value.count - keep))
            result.append(safe)
        }

        public mutating func appendInterpolation(`public` value: String) {
            result.append(value)
        }

        public mutating func appendInterpolation(_ value: Obfuscatable) {
            result.append(value.obfuscated())
        }
        
        // Default interpolation fallback
        public mutating func appendInterpolation<T>(_ value: T) {
            appendLiteral(String(describing: value))
        }
    }
}
