//
//  CustomIconView.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 17.06.22.
//

import SwiftUI

struct CustomIconView: View {
    var color: Color
    var systemNameImageStr: String
    var description: String
    
    init(color: Color = .blue, systemNameImageStr: String = "externaldrive.fill", description: String = "Drive") {
        self.color = color
        self.systemNameImageStr = systemNameImageStr
        self.description = description
    }
    
    var body: some View {
        VStack {
            Image(systemName: systemNameImageStr)
            Text(description)
        }
        .background(in: Circle().inset(by: -20))
        // Only for iOS 16
//        .backgroundStyle(color.gradient)
//        .foregroundStyle(.white.shadow(.drop(radius: 1, y: 1.5)))
        .padding(20)
    }
}

struct CustomIconView_Previews: PreviewProvider {
    static var previews: some View {
        CustomIconView()
    }
}
