//
//  URLRequestConvertible.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import Foundation

public protocol URLRequestConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: HTTPMethods { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension URLRequestConvertible {
    
    public func urlRequest() -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
