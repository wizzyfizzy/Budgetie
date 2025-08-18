# UIComponents Module

A shared collection of **generic UI components** and **UI utilities** designed for use across all features and the Budgetie app.
This module ensures consistent design, reusability, and faster development.

---

## Features

- **Reusable SwiftUI Components**
  - Example: `Pager` — a lightweight pager indicator for flows, carousels, and more.
- **UI Helper Functions**
  - Common view modifiers and utility methods for SwiftUI layouts.
- **Design Extensions**
  - `Color` extensions for app brand colors.
  - `Font` extensions for consistent typography.
  - `Spacing` constants for uniform layout spacing.

---

## Example Components

### Pager
A simple, customizable pager indicator.

```swift
import UIComponents

struct OnboardingView: View {
    @StateObject private var pagerVM = PagerVM(numberOfPages: 3)

    var body: some View {
        VStack {
            Pager(viewModel: pagerVM)
        }
    }
}
```

---

## Extensions

### - Colors
### - Fonts
### - Spacing
