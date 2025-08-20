//
//  RoundedCorner.swift
//  InterfellTC
//
//  Created by Brayan Munoz Campos on 19/08/25.
//

import SwiftUI

/// Una forma personalizada que permite crear esquinas redondeadas específicas en una vista.

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
