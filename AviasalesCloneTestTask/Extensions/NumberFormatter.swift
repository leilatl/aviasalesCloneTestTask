//
//  NumberFormatter.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 01.06.2024.
//

import Foundation

extension NumberFormatter {
    static var priceFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }
    
    static func formatPrice(_ price: Int) -> String {
        return NumberFormatter.priceFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
}
