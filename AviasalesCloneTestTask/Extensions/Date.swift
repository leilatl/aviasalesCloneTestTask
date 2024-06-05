//
//  Date.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import Foundation

extension Date {
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
