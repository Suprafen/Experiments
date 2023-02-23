//
//  ContentView.swift
//  DependencyInjection
//
//  Created by Ivan Pryhara on 23.02.23.
//

import SwiftUI

struct ContentView: View {
    
    // TODO: Consider using Environment Object instead, and provide manager without init.
    @ObservedObject var productsManager: ProductsManager
    
    init(productsManager: ProductsManager) {
        self.productsManager = productsManager
    }
    
    var body: some View {
        List {
            Button {
                productsManager.updateData()
                
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Download")
                }
                .font(.title2)
                .bold()
            }

            ForEach(productsManager.products) { product in
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.title)
                        .bold()
                    Text("Description")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text(product.description)
                        VStack {
                            Text("Rating: \(product.rating)")
                        }
                    }
                }
            }
        }
    }
}
