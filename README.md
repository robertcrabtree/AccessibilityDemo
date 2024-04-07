# Intro

This project demonstrates how to share accessibility identifiers, defined as enums, between your app and UI tests in iOS.

# Set Up

The first thing you need to do is create a static library for your acessibility types:

```
File -> New -> Target -> Static Library -> AccessibilityTypes
```

Navigate to your project file. You need to link the new library to your app and UI test targets. Do this for both targets:

<img width="1127" alt="library" src="https://github.com/robertcrabtree/AccessibilityDemo/assets/924214/8366b1ee-3643-4473-bf40-7e0f2b9b9c6b">

# Example

Now let's use this screen as an example.

![onboarding-screen](https://github.com/robertcrabtree/AccessibilityDemo/assets/924214/8b2f4427-c99b-4527-a861-563d64ebf341)

Add a new file to the `AccessibilityTypes` target and define your accessibilty enum. Make sure it is `public`.

```swift
public enum WelcomeAccessibility: String {
    case loginButton
    case createAccountButton
}
```

From the file inspector, ensure that target membership is applied to the static library.

<img width="259" alt="target-membership" src="https://github.com/robertcrabtree/AccessibilityDemo/assets/924214/e55da8a2-4168-43d6-a4ba-41c5ea183700">


In your view controller file, define a `fileprivate` extension to `UIAccessibilityIdentification` that implements a computed property wrapping the `accessibilityIdentifier` property.

```swift
fileprivate extension UIAccessibilityIdentification {
    var testID: WelcomeAccessibility? {
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

Now let's shift our attention to the test case. But first, let's implement a handy extension that allows us to use the accessibility enum as a subscript key.

```swift
extension XCUIElementQuery {
    subscript(key: WelcomeAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
}
```

And finally, let's write the test case!

```swift
func testLoginFlow() {
    let app = XCUIApplication()
    app.launch()
    app.buttons[WelcomeAccessibility.loginButton].tap()
    // ... Add more test code ...
}
```

Enjoy!
