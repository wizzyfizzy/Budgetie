# Budgetie

**Master your money. Budget it with style.**

Budgetie is a modern full-stack personal finance app built with SwiftUI (Clean Architecture + Combine) and a Node.js/Express backend.

Budgetie was created to simplify personal finance management through clean design and intuitive interactions. It's ideal for users who want budgeting tools without overwhelming complexity.

The iOS project uses [Tuist](https://tuist.io/) to manage the Xcode project, dependencies, and modular structure.

---

## 📁 Monorepo Structure
```Budgetie/
├── ios/ # SwiftUI iOS app
│ └── BudgetieApp/ # Main app target
│ └── Modules/
│ │ └── Core/ # Core modules with business logic, repos, services, etc.
│ │ │ └── UserRepository/
│ │ └── Features/ # Feature modules (e.g., Auth, Profile)
│ │ │ └── Auth/
│ │ └── Shared/ # Shared modules (UI components, helpers, extensions)
│ │ │ └── UIComponents/
│ └── Tests/ # Unit/UI tests
├── api/ # Express backend
│ └── src/ # API logic
│ └── .env # Env variables
└── README.md # This file
```

| Protocol Type | Used In                    |
|---------------|----------------------------|
| `API`         | App or other module        |
| `Impl`        | Internally in module only  |

[Read more about Project Architecture](https://github.com/wizzyfizzy/Budgetie/blob/main/docs/modules.md)

---

## 🚀 Features (Planned)

- ✅ Clean Architecture (Domain / Data / Presentation)
- ✅ MVVM with Combine
- ✅ RESTful API communication
- ✅ Offline Storage (CoreData)
- ✅ Keychain token storage
- ✅ WatchOS companion app + App Group sharing
- ✅ Push Notifications (upcoming payments)
- ✅ Localization (EN / GR)
- ✅ Receipt Scanning (VisionKit)
- ✅ Budgeting suggestions (CoreML)
- ✅ Charts (Swift Charts)
- ✅ WidgetKit (next upcoming payment)
- ✅ Background sync with BGTaskScheduler
- ✅ Dark / Light theme
- ✅ Onboarding with animations
- ✅ Modular architecture (per feature/module)
- ✅ SwiftLint & testing with mocks
- ✅ README with screenshots, video, tech stack, and architecture diagram

---

## 🧪 Tech Stack

### iOS App
- Swift 5.10
- SwiftUI
- Combine
- CoreData
- WidgetKit
- Keychain
- CoreML
- VisionKit
- SwiftLint
- MVVM + Clean Architecture
- Modularized structure per feature
- Unit & UI Tests with Mocks

### Backend
- Node.js (Express.js)
- RESTful API
- JWT Authentication
- MongoDB
- Background tasks
- Hosted on free-tier (e.g. Render, Railway, etc.)

---

## ✅ Code Style & Linting (SwiftLint)

This project uses [SwiftLint](https://github.com/realm/SwiftLint) to enforce consistent Swift code style across the iOS codebase.
- SwiftLint is integrated as a *build script* via Tuist
- Custom rules, disabled checks, and opt-in rules are configured in `.swiftlint.yml`
- Warnings appear in Xcode during builds automatically

[Read full SwiftLint config](https://github.com/wizzyfizzy/Budgetie/blob/main/docs/SwiftLint%20setup.md)

---

## 🪄 Automatic Mock Generation with Sourcery

This project uses [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to **automatically generate mocks** for protocol-based unit tests.

Sourcery is integrated into the **Tuist build process** via a custom pre-build script that runs per module. Mocks are generated based on `@AutoMockable` annotations using a shared `AutoMock.stencil` template.

🔁 **No more boilerplate mocks** — just annotate your protocols and Sourcery takes care of the rest.

✅ **Benefits**:
- Test doubles (mocks) always up-to-date with protocols  
- Eliminates manual maintenance  
- Modular setup scales per feature/module

📁 **Each module** (e.g. `Shared/AppLogging`) includes:
- `.sourcery.yml` configuration  
- Output folder: `/Mocks/`  
- Template reference: shared `AutoMock.stencil`  

🧪 **Example:**
```swift
// Protocol
// sourcery: AutoMockable
protocol LoggingService {
    func log(_ type: LoggingType, fileName: String?, _ message: LoggingMessage)
}

// Sourcery-generated mock
class LoggingServiceMock: LoggingService {
    var logFileName_Void = [/* tracked parameters */]
    ...
}
```

🚀 Mocks are regenerated automatically on each build via Tuist.
[Read more in the Sourcery docs](https://github.com/wizzyfizzy/Budgetie/blob/main/docs/Sourcery.md)

---

## 📷 Demo

*Coming soon: screenshots, preview video, and diagrams.*

---

## 📌 How to Run

### 📱 iOS App (via Tuist)
1. Navigate to the `ios/` folder
2. Run:
- `tuist install`       # Installs correct Tuist version (if needed)
- `tuist clean`         # clears all Tuist-generated data to reset the project’s state 
- `tuist generate`      # Generates the Xcode project/workspace
- open Budgetie.xcworkspace
3. Run the app on iPhone Simulator
✅ SwiftLint will automatically run during builds via Tuist
[Read full Tuist setup](https://github.com/wizzyfizzy/Budgetie/blob/main/docs/Tuist%20setup.md)

### Backend
1. Navigate to `api/`
2. Run: 
- `npm run dev` — Start dev server
- `npm start` — Run in production mode
[Read more](https://github.com/wizzyfizzy/Budgetie/blob/main/api/README.md)

---

## 🔌 Dependency Injection with `@Injected`

We use the `@Injected` property wrapper to resolve dependencies from the shared `BTAppDI` container.

example
```swift
@Injected private var logger: BTLogger
```

This resolves the BTLogger implementation at runtime using our custom dependency injection system (DIModule + BTAppDI).

🔁 Dependencies are registered once, globally.
✅ Safe to use across all modules.
🧪 Easy to mock in tests by re-registering.

All modules can use `@Injected` as long as the type is registered in `BTAppDI`.

📌 Make sure to call `BTAppDI.setUp()` on app launch to initialize dependencies.


### 🔁 Registering Dependencies – Best Practices
**🧩 Case 1: Impl used internally in module**
* ✅ Register locally in module’s DIContainer (FeatureXDI)
* ❌ Don’t expose or register in BTAppDI

```swift
final class MyServiceImpl: MyService { ... }

// FeatureXDI.swift
register(MyService.self) { _ in MyServiceImpl() }
```

**🧩 Case 2: API used externally (by app or other module)**
* ✅ Register the protocol to BTAppDI or the consuming module’s DI.
* ✅ Optionally register mock/stub in tests or preview DI.

```swift
// BTAppDI.swift
register(MyService.self) { _ in MyServiceImpl() }
```

### 🗂️ Quick Reference: Where to Register Dependencies

| Protocol Type | Used In                    | Register In                      |
|---------------|----------------------------|----------------------------------|
| `API`         | App or other module        | `BTAppDI` or consumer DI         |
| `Impl`        | Internally in module only  | Module’s own `DIContainer`       |


---

## 📘 Quick Guide: Adding a New Module to AppNavigation
[Check here](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Shared/AppNavigation/README.md)

---

## 📝 Modules:
### Shared: 
- [AppLogging](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Shared/AppLogging/README.md) for extensible logging
- [AppNavigation](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Shared/AppNavigation/README.md) is a navigation system
- [BTRestClient](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Shared/BTRestClient/README.md) is a generic HTTP clientsystem

- [DIModule](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Shared/DIModule/README.md). Dependency Injection (DI) system that allows mainApp and modules to register and resolve dependencies
- [UIComponents](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Shared/UIComponents/README.md) is a collection of generic UI components and UI utilities

### Features: 
- [Onboarding](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Features/Onboarding/README.md) provides the onboarding flow

### Core: 
- [Auth](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Core/Auth/README.md) provides the authentication flow
---

## 📝 License

All rights reserved. This project is for portfolio and educational purposes.  
Do not reuse without permission.

---
