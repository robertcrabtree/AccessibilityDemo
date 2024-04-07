# Intro

This project demonstrates how to share accessibility enums between your app and UI tests in iOS.

# Set Up

The first thing you need to do is create a static library for your acessibility types:

```
File -> New -> Target -> Static Library -> AccessibilityTypes
```

Navigate to your project file. You need to link the new library to your app and UI test targets. Do this for both targets:

<img width="1127" alt="library" src="https://github.com/robertcrabtree/AccessibilityDemo/assets/924214/7e930123-1604-43a3-8573-4f6cf4bd658d">

# Example

Now let's use this screen as an example.

![onboarding-screen](https://github.com/robertcrabtree/AccessibilityDemo/assets/924214/8b2f4427-c99b-4527-a861-563d64ebf341)

Add a new file to the `AccessibilityTypes` target and define your accessibilty enum.

```swift
enum OnboardingAccessibility: String {
    case loginButton
    case createAccountButton
}
```

From the file inspector, ensure that target membership is applied to the static library.

<img width="259" alt="target-membership" src="https://github.com/robertcrabtree/AccessibilityDemo/assets/924214/e55da8a2-4168-43d6-a4ba-41c5ea183700">


In your view controller file, define a `fileprivate` extension to `UIAccessibilityIdentification` that implements a computed property wrapping the `accessibilityIdentifier` property.

```swift
fileprivate extension UIAccessibilityIdentification {
    var testID: OnboardingAccessibility? {
        get { fatalError() }
        set { accessibilityIdentifier = newValue?.rawValue }
    }
}
```

And don't forget to import the static library:

```swift
import AccessibilityTypes
```

Also in your view controller file, define a method that configures accessibility your all of your view components. Then call the method from `viewDidLoad()`.

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
