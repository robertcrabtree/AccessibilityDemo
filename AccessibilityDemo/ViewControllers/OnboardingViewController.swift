//
//  OnboardingViewController.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/6/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!

    @IBAction func didTapLogin() {
        let vc = UIStoryboard.main.instantiateViewController(
            withIdentifier: "LoginViewController"
        ) as! LoginViewController
        vc.loginHandler = loginHandler
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func didTapCreateAccount() {
        let vc = UIStoryboard.main.instantiateViewController(
            withIdentifier: "CreateAccountViewController"
        ) as! CreateAccountViewController
        vc.createAccountHandler = createAccountHandler
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Variables

    weak var loginHandler: LoginHandler?
    weak var createAccountHandler: CreateAccountHandler?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapper = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapper)
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
