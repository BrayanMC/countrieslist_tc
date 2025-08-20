//
//  InfoRowView.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 20/08/25.
//

import SwiftUI

struct InfoRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    InfoRowView(label: "Region", value: "Erupe")
}
