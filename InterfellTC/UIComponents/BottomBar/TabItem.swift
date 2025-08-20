//
//  TabItem.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

struct TabItem {
    let tab: BottomBarTab
    let view: () -> AnyView

    init(tab: BottomBarTab, view: @escaping () -> AnyView) {
        self.tab = tab
        self.view = view
    }
}
