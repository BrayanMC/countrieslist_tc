//
//  APIResponseConvertible.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import Foundation

protocol APIResponseConvertible: Codable {
    // empty protocol
}

extension APIResponseConvertible {
    func toDomain<U: Codable>() -> U? {
        do {
            let data = try JSONEncoder().encode(self)
            return try JSONDecoder().decode(U.self, from: data)
        } catch {
            debugPrint("Error in \(type(of: self)).\(#function): conversion error")
            return nil
        }
    }
}
