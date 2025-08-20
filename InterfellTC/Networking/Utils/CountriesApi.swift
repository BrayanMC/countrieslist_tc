//
//  CountriesApi.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import Foundation

enum CountriesApi: URLRequestConvertible {
    case all(params: FetchCountriesParams)
    
    var baseURL: URL {
        return URL(string: "https://restcountries.com/v3.1")!
    }
    
    var path: String {
        switch self {
        case .all:
            return "all"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .all(let params):
            guard let fieldsStrings = params.fieldsAsStrings else { return nil }
            return [URLQueryItem(name: "fields", value: fieldsStrings.joined(separator: ","))]
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .all:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .all:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .all:
            return nil
        }
    }
}
