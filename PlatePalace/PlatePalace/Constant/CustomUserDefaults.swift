//
//  CustomUserDefaults.swift
//  LMS
//
//  Created by PHN Tech 2 on 22/01/24.
//

import Foundation

class CustomUserDefaults{
    
    enum DefaultsKey: String, CaseIterable{
        case userId
        case userName
        case userEmail
        case isLoggedIn
        case userPhone
        case userRole
        case authToken
        case trainersAssociatedSchools
        case trainersSelectedSchool
    }
    
    private init() {}
    static let shared = CustomUserDefaults()
    private let defaults = UserDefaults.standard
    
    // to set value using pre-defined key
    func set(_ value: Any?, key: DefaultsKey) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    // get value using pre-defined key
    func get(key: DefaultsKey) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    
    func get<T: Codable>(key: DefaultsKey) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func set<T: Codable>(value: T, forKey key: DefaultsKey) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        defaults.set(data, forKey: key.rawValue)
    }
    
    //Remove all userdefaults
    func resetDefaults() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
