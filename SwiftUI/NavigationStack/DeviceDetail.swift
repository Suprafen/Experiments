//
//  DeviceDetail.swift
//  NavigationStack
//
//  Created by Ivan Pryhara on 17.06.22.
//

import SwiftUI

struct DeviceDetail: View {
    var device: Device
    var body: some View {
        VStack {
            Text(device.model)
        }
    }
}

struct DeviceDetail_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetail(device: Device(model: "iPhone", type: .iPhone))
    }
}
