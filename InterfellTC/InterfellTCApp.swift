//
//  InterfellTCApp.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

@main
struct InterfellTCApp: App {
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            HomeMainView(
                viewModel: ViewModelFactory(coordinator: coordinator).makeHomeMainViewModel()
            )
        }
    }
}
