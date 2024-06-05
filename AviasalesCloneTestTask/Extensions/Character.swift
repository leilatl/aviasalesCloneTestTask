//
//  Character.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 04.06.2024.
//

import Foundation

extension Character {
    var isCyrillic: Bool {
        return ("А"..."я").contains(self) || self == "ё" || self == "Ё"
    }
}
