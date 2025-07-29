# Project Architecture & Structure

This document describes the basic structure of the project and the modular setup we use.

---

## Folder Structure

ios/
├── BudgetieApp/
│ ├── Sources/
│ │ ├── BudgetieApp.swift # App entry point (@main)
│ │ ├── ContentView.swift # Main SwiftUI view
│ ├── Assets.xcassets/ # Images and resources
│ ├── Preview Content/ # SwiftUI previews
│ └── BudgetieApp.xcodeproj # Xcode project file for the main app

├── Modules/
│ ├── Core/ # Core modules with business logic, repos, services, etc.
│ │ └── UserRepository/
│ ├── Features/ # Feature modules (e.g., Auth, Profile)
│ │ └── Auth/
│ └── Shared/ # Shared modules (UI components, helpers, extensions)
│ └── UIComponents/



---

## Description of Modules

### BudgetieApp

- The main app module containing the SwiftUI App entry point (`@main` struct).
- Here we compose all other modules into a functional app.

### Core Modules

- Contain the core business logic, domain models, repositories, and services.
- No UI code here.
- Provide APIs used by Feature modules.

### Feature Modules

- Contain app features (e.g., Authentication, User Profile).
- Use Core and Shared modules.
- Should not depend on other Feature modules (avoid cyclic dependencies).

### Shared Modules

- Contain common UI components, extensions, helper functions, and utilities.
- Independent and used by both Core and Feature modules.

---

## Design Notes

- The modular structure enables easy scalability and good dependency management.
- Modules communicate via well-defined APIs.
- Clear separation between UI and business logic.

---
