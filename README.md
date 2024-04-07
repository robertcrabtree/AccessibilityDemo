This project demonstrates how to define and use enums for accessibility in UI testing on the iOS platorm.

In a new file, separate from your view controller file, define your accessibilty enum.

```swift
enum OnboardingAccessibility: String {
    case loginButton
    case createAccountButton
}
```

From the file inspector, ensure that membership is applied to the app target as well as the UI test target


<img width="258" alt="target-membership" src="https://github.com/robertcrabtree/AccessibilityDemo/assets/924214/65359da9-e1f2-4878-bedc-bffd6bfda022">


In your view controller file, define a `fileprivate` extension to `UIAccessibilityIdentification` that implements a computed property wrapping the `accessibilityIdentifier` property.

```swift
fileprivate extension UIAccessibilityIdentification {
    var testID: OnboardingAccessibility? {
        get { fatalError() }
        set { accessibilityIdentifier = newValue?.rawValue }
    }
}
```

Also in your view controller file, define a method that configures all of your accessibility elements. Then call the method from `viewDidLoad()`.

```swift
private func configureAccessibility() {
    loginButton.testID = .loginButton
    createAccountButton.testID = .createAccountButton
}
```

For convenience, define an extension in your UI test target.

```swift
extension XCUIElementQuery {
    subscript(key: OnboardingAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
}
```

Now write your test case.

```swift
func testLoginFlow() {
    let app = XCUIApplication()
    app.launch()
    app.buttons[OnboardingAccessibility.loginButton].tap()
    // ... Add more test code ...
}
```

Enjoy!
