//
//  UserDefaultsService.swift
//  AviasalesCloneTestTask
//
//  Created by Leila Serebrova on 05.06.2024.
//

import Foundation

class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    private let defaults = UserDefaults.standard
    
    private init() { }
    
    enum Key: String {
        case departure
    }
    
    func set<T>(value: T, for key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func get<T>(for key: Key, defaultValue: T) -> T {
        return defaults.value(forKey: key.rawValue) as? T ?? defaultValue
    }
}
