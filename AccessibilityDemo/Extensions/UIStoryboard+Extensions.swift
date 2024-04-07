//
//  UIStoryboard.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/6/24.
//

import UIKit

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)

    func viewController<VC: UIViewController>(_ type: VC.Type) -> VC {
        instantiateViewController(withIdentifier: String(describing: VC.self)) as! VC
    }
}
