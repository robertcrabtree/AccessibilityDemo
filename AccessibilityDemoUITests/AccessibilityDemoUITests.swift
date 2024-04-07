//
//  AccessibilityDemoUITests.swift
//  AccessibilityDemoUITests
//
//  Created by Robert Crabtree on 4/6/24.
//

import XCTest

final class AccessibilityDemoUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 60))
    }

    func testLoginFlow() {
        app.buttons[OnboardingAccessibility.loginButton].tap()

        XCTAssertTrue(app.textFields[LoginAccessibility.emailTextField].waitForExistence(timeout: 5))
        app.textFields[LoginAccessibility.emailTextField].tap()
        app.textFields[LoginAccessibility.emailTextField].typeText("accessibility@test.com")
        app.secureTextFields[LoginAccessibility.passwordTextField].tap()
        app.secureTextFields[LoginAccessibility.passwordTextField].typeText("astrongpassword")
        app.otherElements[LoginAccessibility.view].tap()
        app.buttons[LoginAccessibility.loginButton].tap()

        XCTAssertTrue(app.buttons[HomeAccessibility.logoutButton].waitForExistence(timeout: 5))
        app.buttons[HomeAccessibility.logoutButton].tap()
    }
}

extension XCUIElementQuery {
    subscript(key: OnboardingAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
    subscript(key: LoginAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
    subscript(key: HomeAccessibility) -> XCUIElement {
        self[key.rawValue]
    }
}
