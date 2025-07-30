# Project Architecture & Structure

This document describes the basic structure of the project and the modular setup we use.

---

## Folder Structure
```
ios/
├── Budgetie.xcodeproj # Xcode project file for the main app
├── Budgetie.xcworkspace
├── BudgetieApp/
│ ├── Sources/
│ │ ├── BudgetieApp.swift # App entry point (@main)
│ │ ├── ContentView.swift # Main SwiftUI view
│ ├── Assets.xcassets/ # Images and resources
│ ├── Preview Content/ # SwiftUI previews
├── Modules/
│ ├── Core/ # Core modules with business logic, repos, services, etc.
│ ├── Features/ # Feature modules (e.g., Auth, Profile)
│ │ └── Auth/
│ └── Shared/ # Shared modules (UI components, helpers, extensions)
│ │ └── UIComponents/
```

---

## Module Groups

Each module belongs to one of the following groups:

- Shared
- Core
- Feature

---

## Description of Modules

### BudgetieApp

- The main app module containing the SwiftUI App entry point (`@main` struct).
- Here we compose all other modules into a functional app.

### Core Modules

Business logic and domain-level modules (e.g. Models, Repositories).
Core modules should not provide screens but can provide individual view elements.
- Located in the folder Modules-Core
- Are able to use Shared Modules
- Should not depend on any other Core or Feature Modules

### Feature Modules
App features like Auth, Budget, Settings. Each is self-contained
- Located in the folder Modules-Feature
- Should *not* use other feature modules
- Are able to use Shared and Core Modules

### Shared Modules
Reusable logic not tied to business logic (e.g. UI components, helpers, extensions). 
- Located in the folder Modules-Shared
- Shared modules can only depend on other Shared modules.
- Should have abstract logic

---

## Module Dependency Rules

- Shared ➜ can be used anywhere
- Core ➜ can use Shared only
- Feature ➜ can use Core + Shared
- 🚫 Feature ➜ cannot use another Feature module

## Module Structure

Each module can have:
- `Sources/API` → Public interfaces
- `Sources/Impl` → Internal implementation
- `Sources/Mocks` → Reusable test mocks


## Public / Internal

Mark only the interfaces in `API` as `public`. Everything else should be `internal` or `private`.


## External Dependencies

Use a `Dependencies` struct to inject external dependencies (e.g. services, repositories).

## Testing & Mocks

Each module must provide mocks for its public API. These go in `Sources/Mocks`.


## Design Notes

- The modular structure enables easy scalability and good dependency management.
- Modules communicate via well-defined APIs.
- Clear separation between UI and business logic.

---
