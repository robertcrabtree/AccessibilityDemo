//
//  SceneDelegate.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/6/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = makeOnboardingViewController()
        window?.makeKeyAndVisible()
    }

    private func makeOnboardingViewController() -> UIViewController {
        let vc = UIStoryboard.main.viewController(OnboardingViewController.self)
        vc.loginHandler = self
        vc.createAccountHandler = self
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }

    private func makeHomeViewController() -> UIViewController {
        let vc = UIStoryboard.main.viewController(HomeViewController.self)
        vc.logoutHandler = self
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }

    private func transition(to vc: UIViewController) {
        guard let window else { return }
        window.rootViewController = vc
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }
}

extension SceneDelegate: LoginHandler {
    func didLogin() {
        transition(to: makeHomeViewController())
    }
}

extension SceneDelegate: CreateAccountHandler {
    func didCreateAccount() {
        transition(to: makeHomeViewController())
    }
}

extension SceneDelegate: LogoutHandler {
    func didLogout() {
        transition(to: makeOnboardingViewController())
    }
}
