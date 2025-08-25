//
//  Copyright © 2025 Budgetie
//
//  All rights reserved.
//  No part of this software may be copied, modified, or distributed without prior written permission.

import Foundation

public enum HTTPError: Error {
    case invalidCredentials
    case userExists
    case userNotFound
    case missingFields
    case unknown
}

/// Protocol for mapping API error codes to Swift errors.
public protocol APIErrorMapping {
    static func map(_ code: String) -> Error
}

extension HTTPError: APIErrorMapping {
    public static func map(_ code: String) -> Error {
        switch code {
        case "InvalidCredentials": return HTTPError.invalidCredentials
        case "UserExists": return HTTPError.userExists
        case "UserNotFound": return HTTPError.userNotFound
        case "MissingFields": return HTTPError.missingFields
        default: return HTTPError.unknown
        }
    }
}
