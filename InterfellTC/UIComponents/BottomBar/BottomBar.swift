//
//  BottomBar.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

struct BottomBar: View {
    @Binding var selectedTab: Int
    var tabs: [BottomBarTab]

    var body: some View {
        HStack {
            ForEach(tabs.indices, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 8) {
                        Image(systemName: tabs[index].icon)
                            .resizable()
                            .scaledToFit()
                            .frame(size: 24)
                        Text(tabs[index].title)
                            .multilineTextAlignment(.center)
                            .font(.caption)
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
                .foregroundColor(selectedTab == index ? .blue : .gray)
            }
        }
        .background(Color.gray.opacity(0.1))
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(.separator)),
            alignment: .top
        )
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color(.systemGray6)
        BottomBar(
            selectedTab: .constant(0),
            tabs: [
                .init(title: "Overview", icon: "star.fill"),
                .init(title: "Maps", icon: "map")
            ]
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
