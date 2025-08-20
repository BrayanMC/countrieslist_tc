//
//  View+Extensions.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func frame(size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
}
