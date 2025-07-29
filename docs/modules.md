# 📦 Modules

## Module Groups

Each module belongs to one of the following groups:

- Shared
- Core
- Feature


### Shared module

Reusable logic not tied to business logic (e.g. UI components, helpers, extensions). 

- Located in the folder Modules-Shared
- Shared modules can only depend on other Shared modules.
- Should have abstract logic


### Core module

Business logic and domain-level modules (e.g. Models, Repositories).
Core modules should not provide screens but can provide individual view elements.
- Located in the folder Modules-Core
- Are able to use Shared Modules
- Should not depend on any other Core or Feature Modules


### Feature module

App features like Auth, Budget, Settings. Each is self-contained
- Located in the folder Modules-Feature
- Should *not* use other feature modules
- Are able to use Shared and Core Modules


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

## Example Folder Structure
Modules/
├── Shared/
│ └── UIComponents/
├── Core/
│ └── BudgetCore/
├── Features/
│ └── BudgetTracking/


## External Dependencies

Use a `Dependencies` struct to inject external dependencies (e.g. services, repositories).

## Testing & Mocks

Each module must provide mocks for its public API. These go in `Sources/Mocks`.
