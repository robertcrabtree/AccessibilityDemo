//
//  CreateAccountViewController.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/7/24.
//

import UIKit
import AccessibilityTypes

protocol CreateAccountHandler: AnyObject {
    func didCreateAccount()
}

class CreateAccountViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!

    @IBAction func didTapCreateAccount() {
        createAccountHandler?.didCreateAccount()
    }

    // MARK: - Variables

    var hasValidCredentials: Bool {
        emailTextField.text.hasText && passwordTextField.text.hasText
    }

    weak var createAccountHandler: CreateAccountHandler?

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
        createAccountButton.isEnabled = false
    }

    private func configureAccessibility() {
        view.testID = .view
        emailTextField.testID = .emailTextField
        passwordTextField.testID = .passwordTextField
        createAccountButton.testID = .createAccountButton
        navigationItem.backBarButtonItem?.testID = .backButton
    }
}

// MARK: - UITextFieldDelegate

extension CreateAccountViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        createAccountButton.isEnabled = hasValidCredentials
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
    var testID: CreateAccountAccessibility? {
        get { fatalError() }
        set { accessibilityIdentifier = newValue?.rawValue }
    }
}
