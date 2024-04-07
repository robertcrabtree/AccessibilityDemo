//
//  LoginViewController.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/6/24.
//

import UIKit

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

        let tapper = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapper)

        navigationController?.navigationBar.tintColor = .systemOrange
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.isEnabled = false
    }

    // MARK: - Action Methods

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        loginButton.isEnabled = hasValidCredentials
        return true
    }
}
