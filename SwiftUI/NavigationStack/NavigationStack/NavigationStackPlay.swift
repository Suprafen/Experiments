//
//  NavigationStack.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 17.06.22.
//

import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case iPhone = "iPhone"
    case iPad = "iPad"
    case macBook = "MacBook"
}

struct NavigationStackPlay: View {
    
    var body: some View {
        NavigationStack {
            List(Category.allCases) { category in
                Section(category.rawValue) {
                    ForEach(Device.devices(in: category)) { device in
                        NavigationLink(device.model, value: device)
                    }
                }
            }
            .navigationTitle("Devices")
            .navigationDestination(for: Device.self) { device in
                DeviceDetail(device: device)
            }
        }
    }
}

struct NavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackPlay()
    }
}
