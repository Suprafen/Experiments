//
//  DependencyInjectionApp.swift
//  DependencyInjection
//
//  Created by Ivan Pryhara on 23.02.23.
//

import SwiftUI
import APIKit

@main
struct DependencyInjectionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(productsManager: ProductsManager(dataFetcher: APIKitLoader()))
        }
    }
}
