# 🧬 Sourcery Integration

This project uses [**Sourcery**](https://github.com/krzysztofzablocki/Sourcery) for automatic mock generation of protocols via annotation.

---

## 💡 What is Sourcery?

Sourcery is a code generation tool for Swift, used to automate repetitive boilerplate code such as mocks, `Equatable`/`Hashable` implementations, etc. It works by parsing the codebase and applying predefined templates.

---

## 🧰 Project Structure

- **Shared Template**  
  `build/Sourcery/Templates/AutoMock.stencil`  
  A shared macro-rich Stencil template that defines how mocks should be generated.

- **Per-Module Configuration**  
  Each module that needs mocks includes a `.sourcery.yml` file under the `Sources/Impl` folder.  
  Example:  
  `ios/Modules/Shared/AppLogging/Sources/Impl/.sourcery.yml`

- **Generated Mocks Output**  
  Mocks are generated into:  
  `ios/Modules/Shared/AppLogging/Sources/Mocks/AutoMock.generated.swift`

---

## 🧾 `.sourcery.yml` Example

```yaml
# Mocks configuration for AppLogging target
sources:
  - ./
templates:
  - ../../../../../../build/Sourcery/Templates/AutoMock.stencil
output:
  ../Mocks
args:
  mockTestableImports: [AppLogging]
```

---

## ✍️ `AutoMock.stencil`
The stencil file defines how mocks are rendered. 
It includes reusable macros for 
- Access levels
- Async/throws/return modifiers
- Parameter formatting for stub and verify
- Unique method naming
- Support for Combine (AnyPublisher)

We annotate protocols with:
```
// sourcery: AutoMockable
protocol MyProtocol { ... }
```
Mocks are generated automatically as `<ProtocolName>Mock`.

---

## ⚙️ Tuist Integration
Sourcery runs automatically during builds via a Tuist `TargetScript`:

```
let sourceryScript = TargetScript.pre(
  script: """
  if which sourcery >/dev/null; then
    echo "🔧 Running Sourcery..."
    find Modules -type f -name .sourcery.yml | while read config; do
      echo "📄 Found config: $config"
      dir=$(dirname "$config")
      echo "🔁 Running Sourcery in $dir"
      sourcery --config "$config"
    done
  else
    echo "⚠️ Sourcery not installed. Run: brew install sourcery"
  fi
  """,
  name: "Sourcery"
)
```
This script:
- Finds every `.sourcery.yml` configuration file across modules
- Runs Sourcery for each, generating mocks automatically
- Outputs the mocks into the corresponding `Sources/Mocks` folders

It is injected into app targets like so:
```
public extension Target {
    static func appTarget(...) -> Target {
        ...
        scripts: [
            swiftLintScript,
            sourceryScript
        ]
    }
}
```

💡 Requires:
```
brew install sourcery
```

---

## 📦 Adding Sourcery to a New Module
1. Add `.sourcery.yml` in the module's `Sources/Impl/`.
2. Reference the shared `AutoMock.stencil` template
3. Annotate the protocols with `// sourcery: AutoMockable`
4. Build the project — mocks will be generated in `Sources/Mocks/`

---

## 🧪 Using the Generated Mocks
Generated mock classes provide:
- `.stub` — to define return values
- `.verify` — to inspect invocations

Example:
```
let mock = AnalyticsLoggingMock()
mock.stub.log = { _ in }

sut.logger = mock
sut.trackEvent(.login)

// Verify
XCTAssertEqual(mock.verify.log.count, 1)
```
