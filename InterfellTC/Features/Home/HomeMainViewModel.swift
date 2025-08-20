//
//  HomeMainViewModel.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import SwiftUI

class HomeMainViewModel: ObservableObject {
    private let coordinator: Coordinator
    private(set) var factory: ViewModelFactory
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.factory = ViewModelFactory(coordinator: coordinator)
    }
    
    func buildTabItems() -> [TabItem] {
        return [
            TabItem(
                tab: .init(title: "Overview", icon: "star.fill"),
                view: { AnyView(self.buildOverviewView()) }
            ),
            TabItem(
                tab: .init(title: "Maps", icon: "map"),
                view: { AnyView(self.buildMapsView()) }
            )
        ]
    }
    
    @ViewBuilder
    private func buildOverviewView() -> some View {
        CountriesView(viewModel: factory.makeCountriesViewModel(displayType: .overview))
    }
    
    @ViewBuilder
    private func buildMapsView() -> some View {
        CountriesView(viewModel: factory.makeCountriesViewModel(displayType: .favorites))
    }
}
