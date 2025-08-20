//
//  BottomBarTab.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import Foundation

struct BottomBarTab: Identifiable {
    let id = UUID()
    let title: String
    let icon: String

    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
}
