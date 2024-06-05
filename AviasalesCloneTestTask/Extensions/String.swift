//
//  String.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import Foundation

extension String {
    func filterCyrillic() -> String {
        return self.filter { $0.isCyrillic }
    }
}
