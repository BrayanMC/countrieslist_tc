//
//  NetworkMonitor.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import Combine
import Network

/// NetworkMonitor utiliza Combine porque NWPathMonitor es basado en callbacks
/// y necesita manejar un stream continuo de cambios de estado de red (WiFi ON/OFF, Cellular, etc.).
/// Combine es ideal para convertir estos eventos callback-based en un stream reactivo.
final class NetworkMonitor: @unchecked Sendable {
    
    private static let queue = DispatchQueue(label: "NetworkMonitor.shared.queue")
    static let shared: NetworkMonitor = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")
    private let subject = CurrentValueSubject<Bool, Never>(false)
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                self.subject.send(true)
            } else {
                self.subject.send(false)
            }
        }
        monitor.start(queue: monitorQueue)
    }
    
    func isNetworkReachable() -> AnyPublisher<Bool, Never> {
        return subject.eraseToAnyPublisher()
    }
}
