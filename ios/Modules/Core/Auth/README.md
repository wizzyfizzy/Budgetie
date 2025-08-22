# Auth Module

The **Auth** module is responsible for handling all user authentication and registration flows within the **Budgetie** app.  
It provides **ViewModels**, **Use Cases**, and **UI Components** related to authentication, ensuring that users can securely create accounts, log in, and manage their sessions.

---

## Features
- User **Sign Up** with name, email & password  
- **Login** with email & password  
- **Sign in with Apple** integration  
- **User session management** via `SaveUserSessionUC`  
- Real-time **form validation** using Combine  
- **Tracking & Analytics** for all user actions (e.g., tap Sign Up, tap Sign In, completed flows)  

---

## Architecture
The module follows **MVVM + Clean Architecture** principles:

- **ViewModels** (`LoginVM`, `SignUpVM`)  
  Manage business logic and UI state.  

- **Use Cases** (e.g., `SaveUserSessionUC`)  
  Encapsulate individual business operations.  

- **Logger / Tracking**  
  All user actions and errors are recorded through the `BTLogger` system.  

---

## Dependencies
- [AppLogging](../AppLogging) → centralized logging & tracking  
- [UIComponents](../UIComponents) → shared UI elements  
- [AuthAPI](../AuthAPI) → contracts/API interfaces  

---

## Interacting Modules
- **AppNavigation** → registers auth views into the navigation flow  
- **UserSession** → persists user session data locally  
- **Backend API (future)** → handles real login & sign-up calls  

---

## Core Components

### `SignUpVM`
- Manages input fields (name, email, password, confirm password)  
- Validates form state via Combine publishers  
- Executes the sign-up flow  
- Calls `SaveUserSessionUC` to persist the session  

### `LoginVM`
- Handles login with email & password  
- Supports **Sign in with Apple** via `appleSignInManager`  
- Tracks login actions and errors  

### Use Cases
- **SaveUserSessionUC** → persists user session data to local storage  

---

## Testing
The Auth module includes **unit tests** covering:
- Input validation (valid/invalid email, password mismatch, terms agreement)  
- State changes within `SignUpVM` and `LoginVM`  
- Tracking & logging actions  
- Success & failure flows for `signUp()` and `login()`  

---

## Demo

- [Video](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Core/Auth/Demo/Demo.mp4)
