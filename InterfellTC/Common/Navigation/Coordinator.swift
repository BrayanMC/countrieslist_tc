//
//  Coordinator.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func popToCount(_ count: Int) {
        guard count >= 0 && count <= path.count else { return }
        let itemsToRemove = path.count - count
        for _ in 0..<itemsToRemove {
            path.removeLast()
        }
    }
    
    var isEmpty: Bool {
        path.isEmpty
    }
    
    var count: Int {
        path.count
    }
}
