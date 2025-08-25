# BTRestClientAPI

`BTRestClientAPI` is a lightweight Swift module that provides a **generic HTTP client** for making network requests in a type-safe and testable way. It abstracts network calls and supports custom endpoints, headers, and error handling. It also includes a **mock client** for unit testing.

---

## ✨ Features

- Type-safe API requests using `HTTPPath` enum.
- Supports `GET`, `POST`, `DELETE`, etc. via `HTTPMethod`.
- Handles JSON encoding/decoding automatically.
- Customizable default headers.
- Custom error mapping per request.
- Stub & verify support for unit testing with `BTRestClientMocks`.

---

## Usage
### Basic Request

```swift
let client = GenericHTTPClient()

let user: UserData = try await client.request(
    path: .signup,
    method: .post,
    body: ["name": "John", "email": "john@test.com", "password": "1234"]
)
```

### Error Mapping

```swift
struct AuthErrorMapping: APIErrorMapping {
    static func map(_ code: String) -> Error {
        switch code {
        case "UserExists": return AuthAPIError.userExists
        case "MissingFields": return AuthAPIError.missingFields
        default: return AuthAPIError.unknown
        }
    }
}

let user: UserData = try await client.request(
    path: .signup,
    method: .post,
    body: ["name": "John", "email": "john@test.com", "password": "1234"],
    errorMapping: AuthErrorMapping.self
)
```

### Mocking for Unit Tests

```swift
let mockClient = BTRestClientMocks()

mockClient.stub = { path, method, body, headers in
    if path == .forgotPassword {
        return DAuthResponseForgotPassword(message: "Password reset email sent")
    }
    return UserData(id: "123", email: "john@test.com", name: "John", token: "token")
}

// Verify call
mockClient.verifyCalled(path: .forgotPassword, method: .post, body: ["email": "john@test.com"])
```

### HTTPPath Enum

```swift
public enum HTTPPath: String {
    case signup = "/signup"
    case login = "/login"
    case forgotPassword = "/forgot-password"
}
```
---
