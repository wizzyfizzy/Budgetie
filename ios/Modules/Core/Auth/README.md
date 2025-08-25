# Auth Module

The **Auth** module is responsible for handling all user authentication and registration flows within the **Budgetie** app.  
It provides **ViewModels**, **Use Cases**, and **UI Components** related to authentication, ensuring that users can securely create accounts, log in, and manage their sessions.

---


## Features
- User **Sign Up** with name, email & password  
- **Login** with email & password  
- **Sign in with Apple** integration  
- **Forgot Password** flow  
- **User session management** via `SaveUserSessionUC`  
- Real-time **form validation** using Combine  
- **Tracking & Analytics** for all user actions (e.g., tap Sign Up, tap Sign In, completed flows)
- **Alerts & error handling** for invalid credentials, existing users, or network issues    

---

## Architecture
The module follows **MVVM + Clean Architecture** principles:

- **ViewModels** (`LoginVM`, `SignUpVM`)  
  Manage business logic, input validation, and UI state.  

- **Use Cases** (e.g., `SaveUserSessionUC`, `LoginUserUC`, `SignUpUserUC`)  
  Encapsulate individual business operations.  

- **Logger / Tracking**  
  All user actions and errors are recorded through the `BTLogger` system.    

---

## Dependencies
- [AppLogging](../AppLogging) → centralized logging & tracking  
- [UIComponents](../UIComponents) → shared UI elements  
- [AuthAPI](../AuthAPI) → contracts/API interfaces
- [BTRestClientAPI](../BTRestClientAPI) → for making network requests    
- Combine & SwiftUI  

---

## Interacting Modules
- **AppNavigation** → registers auth views into the navigation flow  
- **UserSession** → persists user session data locally  
- **Backend API (future)** → handles real login & sign-up calls  

---

## Core Components

### `SignUpVM`
- Manages input fields: **name**, **email**, **password**, **confirm password**, **agreeTerms**  
- Validates form state via Combine publishers:
  - Name ≥ 2 characters
  - Valid email format
  - Password ≥ 6 characters
  - Passwords match
  - Terms accepted
- Executes async **sign-up flow** with `SignUpUserUC`
- Persists session via `SaveUserSessionUC`
- Tracks actions (`tapSignUp`, `completedSignUp`) using `BTLogger`
- Exposes state for SwiftUI views (`isSignUpButtonEnabled`, `errorMessage`, `alert`)

### `LoginVM`
- Handles login with email & password
- Supports **Sign in with Apple** via `appleSignInManager`
- Tracks login actions and errors
- Publishes form validation state for SwiftUI views
- Persists user session via `SaveUserSessionUC`

### Use Cases
- **SaveUserSessionUC** → persists user session data to local storage  
- **LoginUserUC** → executes login flow  
- **SignUpUserUC** → executes sign-up flow  

---

## Testing & Mocks

- **Validation tests**: empty fields, invalid emails, password mismatch, terms agreement  
- **State tests**: `isLoginButtonEnabled`, `isSignUpButtonEnabled`, `errorMessage` updates  
- **Tracking tests**: ensure `BTLogger` is called correctly  
- **Async tests**: `signUp()` and `login()` flows using mocks  

Mocks provided:

- `SignUpUserUCMock`
- `LoginUserUCMock`
- `SaveUserSessionUCMock`
- `BTLoggerMock`



---

## Demo

- [Video](https://github.com/wizzyfizzy/Budgetie/blob/main/ios/Modules/Core/Auth/Demo/Demo.mp4)
