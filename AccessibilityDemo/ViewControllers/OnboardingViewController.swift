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

    // MARK: - Variables

    weak var loginHandler: LoginHandler?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapper = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tapper)
    }

    @IBAction func didTapLogin() {
        let vc = UIStoryboard.main.instantiateViewController(
            withIdentifier: "LoginViewController"
        ) as! LoginViewController
        vc.loginHandler = loginHandler
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapCreateAccount() {}

    // MARK: - Action Methods

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
