# SwiftLint Setup

## What is SwiftLint and Why Use It?

SwiftLint is a tool that helps keep your Swift code clean and consistent by enforcing coding style and best practices automatically.  
It detects common issues like long lines, trailing spaces, unused imports, force casts, and more.  
By using SwiftLint, you ensure that your codebase stays readable, maintainable, and less prone to bugs.

---

## 1. Install SwiftLint

Make sure SwiftLint is installed on your machine (using Homebrew):
```bash
brew install swiftlint
```

Check the version:
```bash
swiftlint version
```


## 2. Create .swiftlint.yml Configuration File

Place this file at the root of your project (where .git is located).

Example .swiftlint.yml:

```yaml
excluded:
  - Pods
  - Carthage
  - .build
  - ios/BudgetieApp/Preview Content

disabled_rules:
  - line_length
  - trailing_whitespace
  - force_cast

line_length:
  warning: 120
  error: 200
  ignores_comments: true
  ignores_urls: true

opt_in_rules:
  - empty_count
  - explicit_self
  - unused_import

custom_rules:
  no_print:
    regex: 'print\('
    message: "Avoid using print statements."
    severity: warning

included:
  - ios/

swift_version: 5.7
```


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

## 4. Run and Fix Warnings
From the project root folder, run SwiftLint in terminal:

```bash
swiftlint lint --config .swiftlint.yml
```

Fix any warnings shown (like trailing commas).

Then build your project in Xcode to confirm SwiftLint runs successfully during builds.
