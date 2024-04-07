//
//  Optional+Extensions.swift
//  AccessibilityDemo
//
//  Created by Robert Crabtree on 4/7/24.
//

import Foundation

extension Optional where Wrapped == String {
    var hasText: Bool {
        switch self {
        case .none: return false
        case .some(let text): return text
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .count > 0
        }
    }
}
