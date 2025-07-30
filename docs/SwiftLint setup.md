# SwiftLint Configuration for Budgetie

This document explains the SwiftLint configuration used in the **Budgetie** iOS project. SwiftLint is a linter tool that enforces Swift style and conventions.

---

## 📄 What is SwiftLint?

[SwiftLint](https://github.com/realm/SwiftLint) is a tool to enforce Swift style and coding conventions. It scans the Swift files and warns about:
- Style violations
- Bad practices
- Unused code

It helps keep the codebase consistent and clean across the team.

---

## 1. Install SwiftLint

Make sure SwiftLint is installed on the machine (using Homebrew):
```bash
brew install swiftlint
```

Check the version:
```bash
swiftlint version
```

---

## 2. Create `.swiftlint.yml` Configuration File

The `.swiftlint.yml` defines how SwiftLint should behave.
This file should be placed at the root of the project (where .git is located).

### 🧩 Categories Explained

#### `included`
- Defines which folders SwiftLint should scan.
```yaml
included:
  - ios/
```

#### `excluded`
- Directories that SwiftLint should ignore.
```yaml
excluded:
  - Pods
  - Carthage
  - .build
  - ios/BudgetieApp/Preview Content
```

#### `disabled_rules`
- Rules that are turned off completely.
```yaml
disabled_rules:
  - trailing_whitespace
  - force_cast
  - line_length
```

#### `opt_in_rules`
- These are **not enabled by default**, but are useful for stricter checking.
```yaml
opt_in_rules:
  - empty_count
```

#### `analyzer_rules`
- Rules that use the SwiftSyntax engine. More accurate but slower.
```yaml
analyzer_rules:
  - explicit_self
  - unused_import
```

#### `custom_rules`
- Custom rules defined using regular expressions.
```yaml
custom_rules:
  no_print:
    name: "No Print Statements"
    regex: 'print\(.*\)'
    message: "Avoid using print statements. Use os_log or Logger instead."
    severity: warning
```

---

## 📌 Rule Details

### ✅ opt_in_rules
| Rule | Description |
|------|-------------|
| `empty_count` | Prefer `isEmpty` over `count == 0` |
| `first_where` | Use `.first(where:)` instead of filtering then calling `.first` |
| `yoda_condition` | Avoid writing `5 == value`; write `value == 5` instead |
| `fatal_error_message` | Require a descriptive message in `fatalError()` |
| `unneeded_parentheses_in_closure_argument` | Removes unnecessary parentheses in closures |

### 🧠 analyzer_rules
| Rule | Description |
|------|-------------|
| `explicit_self` | Require `self.` usage in closures or initializers |
| `unused_import` | Detect unused imports |
| `redundant_optional_initialization` | Flags `var x: Int? = nil` as redundant |
| `prefer_self_type_over_type_of_self` | Prefer `Self` instead of `type(of: self)` |

### ⛔ disabled_rules
| Rule | Why it may be disabled |
|------|------------------------|
| `line_length` | SwiftUI/Combine often needs long lines |
| `force_cast` | Sometimes useful in tests or for rapid prototyping |
| `trailing_whitespace` | Can be noisy, especially in team environments |

---


## 3. Add SwiftLint Run Script in Xcode

### Adding SwiftLint to Xcode Build Phases

1. Open your Xcode project.
2. Go to the **BudgetieApp** target → **Build Phases** tab.
3. Click the **+** button and select **New Run Script Phase**.
4. The new **Run Script** will appear at the bottom of the list.
5. Click and drag the **Run Script** cell above **Compile Sources** — it should run *before* compilation.
6. In the script box, paste the following:

```sh
if which swiftlint >/dev/null; then
echo "SRCROOT is: ${SRCROOT}"
cd "${SRCROOT}/../" || exit  # move up one folder to ios/
swiftlint lint
else
  echo "warning: SwiftLint not installed. Download from https://github.com/realm/SwiftLint"
fi
```

Disable Based on dependency analysis option in this Run Script Phase to avoid build warnings.

---

## 4. Run and Fix Warnings
From the project root folder, run SwiftLint in terminal:

```bash
swiftlint lint --config .swiftlint.yml
```

Fix any warnings shown (like trailing commas).

Then build your project in Xcode to confirm SwiftLint runs successfully during builds.

---

## ✅ Summary

- SwiftLint helps enforce clean, consistent code.
- Rules are grouped into included/excluded, disabled, opt-in, analyzer, and custom.
- Custom rules like `no_print` help enforce team-specific conventions.
- Run SwiftLint automatically in Xcode via build phases.
