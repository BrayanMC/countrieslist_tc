//
//  HomeMainView.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

struct HomeMainView: View {
    @ObservedObject var viewModel: HomeMainViewModel
    
    var body: some View {
        ContentView(
            tabItems: viewModel.buildTabItems()
        )
    }
}

struct ContentView: View {
    var tabItems: [TabItem]
    @State private var selectedTab = 0
    
    var body: some View {
        tabItems[selectedTab]
            .view()
            .safeAreaInset(edge: .bottom) {
                BottomBar(
                    selectedTab: $selectedTab,
                    tabs: tabItems.map { $0.tab }
                )
                .background(.ultraThinMaterial)
            }
    }
}

#Preview {
    ContentView(
        tabItems: [
            TabItem(
                tab: .init(title: "Overview", icon: "star.fill"),
                view: { AnyView(Color.white) }
            ),
            TabItem(
                tab: .init(title: "Maps", icon: "map"),
                view: { AnyView(Color.white) }
            )
        ]
    )
}
