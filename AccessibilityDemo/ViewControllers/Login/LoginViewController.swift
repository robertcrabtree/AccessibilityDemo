//
//  LoginViewController.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/6/24.
//

import UIKit
import AccessibilityTypes

protocol LoginHandler: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    @IBAction func didTapLogin() {
        loginHandler?.didLogin()
    }

    // MARK: - Variables

    var hasValidCredentials: Bool {
        emailTextField.text.hasText && passwordTextField.text.hasText
    }

    weak var loginHandler: LoginHandler?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureComponents()
        configureAccessibility()
    }

    // MARK: - Action Methods

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Helper Methods

    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemOrange
    }

    private func configureView() {
        let tapper = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapper)
    }

    private func configureComponents() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.isEnabled = false
    }

    private func configureAccessibility() {
        view.testID = .view
        emailTextField.testID = .emailTextField
        passwordTextField.testID = .passwordTextField
        loginButton.testID = .loginButton
        navigationItem.backBarButtonItem?.testID = .backButton
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        loginButton.isEnabled = hasValidCredentials
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - UIAccessibilityIdentification

fileprivate extension UIAccessibilityIdentification {
    var testID: LoginAccessibility? {
        get { fatalError() }
        set { accessibilityIdentifier = newValue?.rawValue }
    }
}
