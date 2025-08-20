//
//  ServiceManager.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import Foundation
import Combine

public final class ServiceManager {
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        // empty
    }
    
    public func request<T: Codable>(_ request: URLRequestConvertible, type: T.Type) async throws -> T? {
        let urlRequest = request.urlRequest()
        print("Starting request: \(urlRequest.url?.absoluteString ?? "Unknown URL")")
        
        // Convierte el stream de Combine a async/await esperando el primer valor 'true'
        // con timeout de 3 segundos para evitar esperas indefinidas
        let isReachable = await withCheckedContinuation { continuation in
            NetworkMonitor.shared.isNetworkReachable()
                .first { $0 == true }
                .timeout(.seconds(3), scheduler: RunLoop.main)
                .sink(
                    receiveCompletion: { completion in
                        if case .failure = completion {
                            continuation.resume(returning: false) // Timeout
                        }
                    },
                    receiveValue: { isConnected in
                        continuation.resume(returning: isConnected)
                    }
                )
                .store(in: &cancellables)
        }
        
        guard isReachable else {
            print("No network connection")
            throw ServiceError.noConnection
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ServiceError.invalidResponse
            }
            
            print("Received response: \(httpResponse.statusCode) for URL: \(urlRequest.url?.absoluteString ?? "Unknown URL")")
            
            switch httpResponse.statusCode {
            case 200...299:
                if let utf8String = String(data: data, encoding: .utf8) {
                    print("Response data in UTF-8: \(utf8String)")
                } else {
                    print("Failed to convert data to UTF-8 string")
                }
                
                #if DEBUG
                print("------\(httpResponse.statusCode)------\(request.urlRequest())------\(httpResponse.statusCode)------")
                #endif
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    print("Decoded data: \(decodedData)")
                    return decodedData
                } catch {
                    print("Decoding error: \(error)")
                    throw ServiceError.invalidResponse
                }
            case 401:
                #if DEBUG
                print("------\(httpResponse.statusCode)------\(request.urlRequest())------\(httpResponse.statusCode)------")
                #endif
                throw ServiceError.unauthorized
            case 429:
                #if DEBUG
                print("------\(httpResponse.statusCode)------\(request.urlRequest())------\(httpResponse.statusCode)------")
                #endif
                throw ServiceError.rateLimit
            default:
                #if DEBUG
                print("------\(httpResponse.statusCode)------\(request.urlRequest())------\(httpResponse.statusCode)------")
                #endif
                throw ServiceError.invalidResponse
            }
        } catch {
            print("Request failed with error: \(error)")
            if let serviceError = error as? ServiceError {
                throw serviceError
            } else {
                throw ServiceError.invalidURLRequest
            }
        }
    }
}
