//
//  CountriesApi.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import Foundation

enum CountriesApi: URLRequestConvertible {
    case all(params: FetchCountriesParams)
    case byName(name: String, fullText: Bool = false)
    
    var baseURL: URL {
        return URL(string: "https://restcountries.com/v3.1")!
    }
    
    var path: String {
        switch self {
        case .all:
            return "all"
        case .byName(let name, _):
            return "name/\(name)"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .all(let params):
            guard let fieldsStrings = params.fieldsAsStrings else { return nil }
            return [URLQueryItem(name: "fields", value: fieldsStrings.joined(separator: ","))]
        case .byName(_, let fullText):
            return [URLQueryItem(name: "fullText", value: String(fullText))]
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .all, .byName:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .all, .byName:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .all, .byName:
            return nil
        }
    }
}
