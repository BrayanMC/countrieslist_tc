//
//  CountryDetailViewModel.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import SwiftUI

class CountryDetailViewModel: ObservableObject {
    private(set) var country: Country
    private let coordinator: Coordinator
    
    init(country: Country, coordinator: Coordinator) {
        self.country = country
        self.coordinator = coordinator
    }
    
    func back() {
        coordinator.pop()
    }
}
