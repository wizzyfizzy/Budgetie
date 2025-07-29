# Budgetie

**Master your money. Budget it with style.**

Budgetie is a modern full-stack personal finance app built with SwiftUI (Clean Architecture + Combine) and a Node.js/Express backend.

Budgetie was created to simplify personal finance management through clean design and intuitive interactions. It's ideal for users who want budgeting tools without overwhelming complexity.

---

## 📁 Monorepo Structure
```Budgetie/
├── ios/ # SwiftUI iOS app
│ └── BudgetieApp/ # Main app target
│ └── Modules/ # Feature-based modules
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

This project uses [SwiftLint](https://github.com/realm/SwiftLint) to enforce consistent Swift style and conventions.
[Read more](https://github.com/wizzyfizzy/Budgetie/blob/main/docs/SwiftLint%20setup.md)

## 📷 Demo

*Coming soon: screenshots, preview video, and diagrams.*

---

## 📌 How to Run

### iOS App
1. Navigate to `ios/`
2. Open `Budgetie.xcodeproj`
3. Run on iPhone Simulator

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



