# AppNavigation Module

**AppNavigation** is a decoupled navigation system for SwiftUI applications using a **registry-based approach**.
It allows each feature module to declare its own navigation destinations without coupling to SwiftUI's `NavigationStack` or `.sheet` directly.
**AppNavigation** is a `shared` Swift module and it is compatible with `Sourcery` for auto-generating mocks.

---

## ✨ Key Goals
It supports:  
- Keep navigation logic out of feature modules
- Support both `.push` and `.sheet` navigation types
- Allow dynamic registration of new screens from any module
- Keep it fully testable and dependency-injectable

---

## How it Works

### Components

1. **NavigationData**
   - A marker protocol that represents a navigation destination.
   - Each screen has its own public struct conforming to `NavigationData`.
   - Example:
     ```swift
     public struct OnboardingNavData: NavigationData {
         public init() {}
     }
     ```

2. **NavigationRegistry**
   - Stores mappings between `NavigationData` types and their SwiftUI views.
   - Allows resolving a view for a given `NavigationData` instance at runtime.

3. **NavigationContext** in  Main App
   - Holds SwiftUI navigation state (`path` for pushes, `sheetView` for modals).
   - Provides closure (`navigationHandler`) that update the state.
   - Is observed by SwiftUI views for reactive navigation.

4. **AppNavigateToUC**
   - A use case for triggering navigation from anywhere in the app.
   - Calls the appropriate handler in `NavigationContext`.

---

## Dependency Injection Setup

In the BTAppDI container:
```swift
private func registerAppNavigationModules() {
    // Create and store registry
    let registry = NavigationRegistryFactoryImpl.make()
    self.navigationRegistry = registry
    
    // Register views from each module
    OnboardingNavigationViewProvider.register(in: registry)
    // Add more modules here...

    // Create NavigationContext
    let navContext = NavigationContext(registry: registry)
    self.navigationContext = navContext

    // Register NavigationContext & AppNavigateToUC
    register(NavigationContext.self) { _ in navContext }
    register(AppNavigateToUC.self) { _ in
        AppNavigateToUCImpl(navigationHandler: navContext.navigationHandler)
    }
}
```

---

## 📘 Quick Guide: Adding a New Module to AppNavigation

### 1. Define NavigationData

```swift
public struct MyFeatureNavData: NavigationData {
    public let id: UUID
    public init(id: UUID) { self.id = id }
}
```

### 2. Create a ViewProvider in the Feature Module to register the View 

```swift
public enum MyFeatureNavigationViewProvider {
    public static func register(in registry: NavigationRegistryProtocol) {
        registry.registerView(MyFeatureNavData.self) { data in
            AnyView(MyFeatureView(id: data.id))
        }
    }
}
```

### 3. Register the View in Main App DI (BTAppDI)

```swift
MyFeatureNavigationViewProvider.register(in: navigationRegistry)
```

---

## Using Navigation in a View
Inject AppNavigateToUC via DI and call:

```swift
navigateToUC.execute(data: MyFeatureNavData(id: UUID()), type: .push)
navigateToUC.execute(data: MyFeatureNavData(id: UUID()), type: .sheet)
```

In the root view:
```swift
NavigationStack(path: $navContext.path) {
    // Your root content...
}
.sheet(item: $navContext.sheetView) { wrapper in
    wrapper.view
        .interactiveDismissDisabled(true) // Optional: disable dismiss
}
```

## 5️⃣ Summary / Best Practices
┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
|            Step                    |                        Purpose                                |
|    Create `NavigationData`         |  Type-safe parameters for view navigation                     |
|    Create `ViewProvider`           |  Each module registers its views without main app knowledge   |
|    Register in `BTAppDI`           |  Provide a shared NavigationRegistry and navigation use case  |
|    Use `navigateToUC.execute`      |  Push or present the view via NavigationStack or Sheet        |
└────────────────────────────────────────────────────────────────────────────────────────────────────┘

---

## Diagram flow
┌───────────────────────────┐
│        User Action        │
│ (i.e. clicks "Go to X")   │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ AppNavigateToUC.execute   │
│   data: NavigationData    │
│   type: NavigationType    │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Navigation Handler        │
│ (pushHandler/sheetHandler)│
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ NavigationRegistry        │
│ resolveView(data)         │
│   1. Gets ObjectIdentifier|
│   2. Finds builder closure│
│   3. Creates SwiftUI View │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ AnyViewWrapper(view)      │
│ + UUID ως μοναδικό id     │
└─────────────┬─────────────┘
              │
              ▼
       ┌──────────────┐
       │ SwiftUI      │
       │ .navigationUC│
       │   .push      |
       | or .sheet    │
       └──────────────┘


---

## Benefits
- Loose coupling between navigation and features
- Supports dynamic runtime view resolution
- Testable without SwiftUI runtime
- Easily extendable for new navigation types

