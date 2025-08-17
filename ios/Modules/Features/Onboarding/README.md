# Onboarding Module

The **Onboarding module** provides the onboarding flow for **Budgetie**, guiding new users through the main features of the app.  
It includes navigation setup, state management, persistence, and UI components.

---

## Features

- **Navigation Integration**  
  - `OnboardingNavData` for navigation data  
  - `OnboardingNavigationViewProvider` for registry setup  
- **API Layer**  
  - `ShouldShowOnboardingUC` – decides if onboarding should be displayed  
- **Internal Functionality Layer**
  - `CompleteOnboardingUC` – marks onboarding as completed  
  - `OnboardingRepo` – repository interface  
  - `OnboardingSource` – persistence interface  
  - Default implementations use `UserDefaults`  
- **Presentation Layer**  
  - `OnboardingVM` – view model with auto-scroll, step navigation, and tracking  
  - `OnboardingView` – SwiftUI view with `TabView`, pager, skip/next buttons  

---

## Usage

### Register Onboarding in Navigation
```swift
OnboardingNavigationViewProvider.register(in: registry)
