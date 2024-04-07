//
//  HomeViewController.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/7/24.
//

import UIKit

protocol LogoutHandler: AnyObject {
    func didLogout()
}

class HomeViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var welcomeLabel: UILabel!

    // MARK: - Variables

    lazy var logoutButton = UIBarButtonItem(
        title: "Log Out",
        primaryAction: UIAction(
            handler: { [weak self] _ in
                self?.logoutHandler?.didLogout()
            }
        )
    )

    weak var logoutHandler: LogoutHandler?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = logoutButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Action Methods
}
