//
//  CornerRadiusViewModifier.swift
//  Sport-Crowd
//
//  Created by Ivan Pryhara on 17.03.23.
//

import Foundation
import SwiftUI

// MARK: Reference - https://stackoverflow.com/a/58606176/16703493

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
