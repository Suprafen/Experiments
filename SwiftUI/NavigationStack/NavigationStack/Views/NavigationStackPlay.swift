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
@available(iOS 16, *)
struct NavigationStackPlay: View {
    
    var body: some View {
        VStack {
            
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
            
            AddButtonView()
        }
    }
}

struct NavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16, *) {
            NavigationStackPlay()
        }
    }
}
