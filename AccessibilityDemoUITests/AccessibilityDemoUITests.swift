//
//  AccessibilityDemoUITests.swift
//  AccessibilityDemoUITests
//
//  Created by Robert Crabtree on 4/6/24.
//

import XCTest
import AccessibilityTypes

final class AccessibilityDemoUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 60))
    }

    func testLoginFlow() {
        app.buttons[WelcomeAccessibility.loginButton].tap()

        // Wait for login view to appear
        XCTAssertTrue(app.textFields[LoginAccessibility.emailTextField].waitForExistence(timeout: 5))

        app.textFields[LoginAccessibility.emailTextField].tap()
        app.textFields[LoginAccessibility.emailTextField].typeText("accessibility@test.com")

        app.secureTextFields[LoginAccessibility.passwordTextField].tap()
        app.secureTextFields[LoginAccessibility.passwordTextField].typeText("astrongpassword")

        // dismiss the keyboard so loginButton is visible
        app.otherElements[LoginAccessibility.view].tap()

        app.buttons[LoginAccessibility.loginButton].tap()

        // wait for home view to appear
        XCTAssertTrue(app.buttons[HomeAccessibility.logoutButton].waitForExistence(timeout: 5))

        app.buttons[HomeAccessibility.logoutButton].tap()

        app.alerts.buttons[HomeAccessibility.logoutOKAction].tap()
    }
}

extension XCUIElementQuery {
    subscript(key: WelcomeAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
    subscript(key: LoginAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
    subscript(key: HomeAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
}
