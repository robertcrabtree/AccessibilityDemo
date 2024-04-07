//
//  Button.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/6/24.
//

import UIKit

class Button: UIButton {

    override var isEnabled: Bool {
        didSet { updateConfig() }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func commonInit() {
        updateConfig()
        setTitleColor(.white, for: .normal)
    }

    private func updateConfig() {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = isEnabled
            ? .systemOrange
            : .systemOrange.withAlphaComponent(0.65)
        config.cornerStyle = .medium
        config.title = self.titleLabel?.text
        configuration = config
    }
}
