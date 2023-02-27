//
//  UserDefaults+Extension.swift
//  tasbih
//
//  Created by Khalil Sabirov on 22.02.2023.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsError: Error {
        case failureEncode
        case failuerDecode
        case noData
    }
    
    func saveModel<T: Encodable>(_ model: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(model)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getModel<T: Decodable>(forKey key: String) throws -> T {
        guard let data = UserDefaults.standard.data(forKey: key) else { throw UserDefaultsError.noData }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
