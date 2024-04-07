//
//  OnboardingViewController.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/6/24.
//

import UIKit
import AccessibilityTypes

class OnboardingViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!

    @IBAction func didTapLogin() {
        let vc = UIStoryboard.main.viewController(LoginViewController.self)
        vc.loginHandler = loginHandler
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func didTapCreateAccount() {
        let vc = UIStoryboard.main.viewController(CreateAccountViewController.self)
        vc.createAccountHandler = createAccountHandler
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Variables

    weak var loginHandler: LoginHandler?
    weak var createAccountHandler: CreateAccountHandler?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAccessibility()
    }

    // MARK: - Action Methods

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Helper Methods

    private func configureAccessibility() {
        loginButton.testID = .loginButton
        createAccountButton.testID = .createAccountButton
    }
}

// MARK: - UIAccessibilityIdentification

fileprivate extension UIAccessibilityIdentification {
    var testID: OnboardingAccessibility? {
        get { fatalError() }
        set { accessibilityIdentifier = newValue?.rawValue }
    }
}
