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

## 📷 Demo

*Coming soon: screenshots, preview video, and diagrams.*

---

## 📌 How to Run

### 📱 iOS App (via Tuist)
1. Navigate to the `ios/` folder
2. Run:
- `tuist install`       # Installs correct Tuist version (if needed)
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

## 📝 License

All rights reserved. This project is for portfolio and educational purposes.  
Do not reuse without permission.

---
