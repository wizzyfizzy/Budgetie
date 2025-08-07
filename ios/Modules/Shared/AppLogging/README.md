# AppLogging

**AppLogging** is a shared Swift module for safe, structured, and extensible logging.
AppLogging is compatible with `Sourcery` for auto-generating mocks of `BTLogger`.

---

## ✨ Features
It supports:  
- ✅ Structured logs  
- ✅ Obfuscation for sensitive data  
- ✅ Native logging via `OSLog`  
- ✅ Unit-testable logger via the `BTLogger` protocol

---

## Who is it for?
AppLogging is ideal for:
- Modular iOS projects needing consistent logging
- Teams that value privacy and testability
- Codebases using OSLog and needing structured log formatting

---

### Logging Levels

```swift
public enum LoggingType: String {
    case debug, info, warning, error
}
```
---

## 🚀 Usage
```
let logger = logger(module: "Network") // returns BTLogger
logger.log(.info, fileName: "LoginVC", "User logged in with id: \(id: "abc123")")
logger.log(.error, fileName: "APIManager", "Failed to fetch data: \(errorMessage)")
```
---


## 🧪 Logging Message
LoggingMessage allows you to safely format log messages using StringInterpolation:

```
let id = "abc123"
let token = "secret-token"

let msg: LoggingMessage = "User ID: \(id: id), Token: \(token, keep: 2)"
// Output: User ID: {"id": "abc123"}, Token: se**********
```

---

## 🔐 Built-in Obfuscation Helpers
```
| Interpolation                 | Description                                             |
|-------------------------------|---------------------------------------------------------|
| `\(id: value)`                | Tags an identifier in a structured, loggable format     |
| `\(json: jsonData)`           | Obfuscates values inside a JSON payload                 |
| `\(value, keep: n)`           | Keeps the first `n` characters, masks the rest          |
| `\(public: value)`            | Explicitly logs as-is without obfuscation               |
| `\(someObfuscatableInstance)` | Calls `.obfuscated()` from a custom `Obfuscatable` type |
```

---

## 🔒 Obfuscatable Protocol
To log custom types safely:

```
struct Token: Obfuscatable {
    let rawValue: String

    func obfuscated() -> String {
        return "REDACTED"
    }
}

let msg: LoggingMessage = "Token: \(Token(rawValue: "abc"))"
// Output: Token: REDACTED
```

---

## 🧪 Testing
The AppLoggingTests module includes:
- Verification of LoggingMessage formatting
- Obfuscation and JSON rendering tests

```
func testLoggingMessageInterpolations() {
    let json = #"{"email":"test@example.com","password":"123"}"#.data(using: .utf8)!
    let msg: LoggingMessage = "Payload: \(json: json)"
    XCTAssertTrue(msg.description.contains("********"))
}
```

---

## 📦 Integration
### Swift Package

```
.package(path: "../AppLogging")
```
