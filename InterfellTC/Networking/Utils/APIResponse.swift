//
//  APIResponse.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

struct APIResponse<T: Codable>: Codable {
    let message: String?
    let success: Int?
    let code: Int?
    let status: Bool?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case message, success, code, status, data
    }
}
