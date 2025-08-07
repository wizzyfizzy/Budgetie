# DIModule

A lightweight and flexible **Dependency Injection (DI) system**. It allows **modules to register and resolve dependencies** in a clean and testable way, while also supporting property wrappers for automatic injection.

---

## ✨ Features

- ✅ Simple registration of services using instances or factory closures
- ✅ Lazy instantiation via closures
- ✅ Protocol-based interface (DIResolver)
- ✅ Global shared container (DIContainer.default)
- ✅ Fatal error override support for unit testing

---

## 📁 Structure
```DIModule/
│
├── API/
│ ├── DIResolver.swift # protocol│
└── Impl/
│ ├── Errors/
│ │ └── Errors.swift # Testable override for fatalError
│ ├── DIContainer.swift

```
                                                                                
---

## 🚀 Usage

### 1. Registering Dependencies

We can register either:
- A factory (closure): lazily creates the instance.
- A concrete instance: directly provided at registration.

In the app or module-specific DI container:

```swift
let container = DIContainer()

// Register a concrete instance
container.register(MyViewModel.self, instance: MyViewModel())

// Register using a factory closure
container.register(MyRepo.self) { _ in MyRepoImpl() }
```

### 2. Resolving Dependencies
Option A: Manual Resolution
```
let myRepo: MyRepo = container.resolve()
```
We can also use the global default container:
```
DIContainer.default.register(MyRepo.self, instance: MyRepoImpl())
let resolved: MyRepo = DIContainer.default.resolve()
```

Option B: Automatic with @Injected
```
final class MyViewModel {
    @Injected var myRepo: MyRepo
    
    func doSomething() {
        myRepo.performTask()
    }
}
```

## 🧠 How it Works
### DIContainer:
Handles all logic for registering and resolving dependencies:
- register(type:factory:): Registers a lazy factory closure
- register(type:instance:): Registers a concrete instance
- resolve(type:): Retrieves the instance, from cache or by calling factory

Internally uses:
```
private var factories: [ObjectIdentifier: (DIContainer) -> Any]
private var instances: [ObjectIdentifier: Any]
```
                        
The ObjectIdentifier uniquely identifies a type like MyRepo.self, used as a dictionary key.

### Testing Support
In Impl/Errors.swift, there's a global fatalError override for unit testing.

We can mock fatalError to verify failure conditions during tests.

```
// Override before test
fatalErrorClosure = { message, _, _ in
    print("Intercepted fatalError: \(message)")
    throw TestFatalError(message)
}
```

## 📌 Example
```
// Define protocol
protocol Logger {
    func log(_ message: String)
}

// Implementation
final class LoggerImpl: Logger {
    func log(_ message: String) {
        print("[Log]: \(message)")
    }
}

// Register
let container = DIContainer()
container.register(Logger.self) { _ in LoggerImpl() }

// Use
final class MyRepo {
    @Injected var logger: Logger
    
    func doSomething() {
        logger.log("Working...")
    }
}
```

---

## 🧪 Unit Testing
### ✅ Unit Test: Resolving an instance
```
func test_resolvesRegisteredInstance() {
    let container = DIContainer()
    container.register(MyRepo.self, instance: MyRepoImpl())

    let resolved: MyRepo = container.resolve()
    XCTAssertNotNil(resolved)
}
```

### ✅ Expecting crash on unregistered dependency

```
func test_unregisteredDependency_shouldCrash() {
    let container = DIContainer()

    expectFatalError {
        let _: MyRepo = container.resolve()
    }
}
```

---

## 📚 Naming Conventions
Each module should define its own DI container subclass:

```
final class AuthDI: DIContainer {
    static var shared = AuthDI()

    override init() {
        super.init()
        AuthDI.shared = self
        registerDependencies()
    }

    private func registerDependencies() {
        register(AuthRepo.self) { _ in AuthRepoImpl() }
        register(LoginUC.self) { _ in LoginUCImpl() }
    }
}
```

---

## ❓ FAQ
- Why use ObjectIdentifier?
Because it uniquely identifies types like MyRepo.self, making it safe to use as a dictionary key.

- Why @escaping (DIContainer) -> T?
The factory must escape the current scope so it can be stored and called later.

- Why both factory and instance?
factory = lazy creation (like a closure)
instance = direct reference (already exists)

---

## 📦 Integration
Swift Package Manager
```
.package(path: "../DIModule")

.target(
    name: "MyApp",
    dependencies: [
        .product(name: "DIModule", package: "DIModule")
    ]
)
```

---

## 🧼 Best Practices
- Use @Injected for cleaner code
- Keep DI registrations in one place per module
- Fail early using fatalError if a dependency is missing
- Make views, VMs, and use cases depend on protocols, not concrete types
