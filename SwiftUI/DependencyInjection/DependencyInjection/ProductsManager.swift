//
//  ProductsManager.swift
//  DependencyInjection
//
//  Created by Ivan Pryhara on 23.02.23.
//

import Foundation
import SwiftUI
import SwiftyJSON

class ProductsManager: ObservableObject {
    /// Any type that can conform to `GetDataable`
    private var dataFetcher: GetDataable
    
   @Published var products: [Product] = []
    
    init(dataFetcher: GetDataable) {
        self.dataFetcher = dataFetcher
    }
    
    func updateData() {
        dataFetcher.getData { [weak self] data in
            guard let data else { fatalError("Can't unwrap data in \(#function)")}
            
            guard let products = JSON(data)["products"].array else { fatalError("Can't unwrap products in \(#function)")}
            
            DispatchQueue.main.async {
                if let prod = self?.products, !prod.isEmpty {
                    self?.products.removeAll()
                }
            }
            
            for product in products {
                
                guard let prodDic = product.dictionary,
                      let id = prodDic["id"]?.int,
                      let title = prodDic["title"]?.string,
                      let description = prodDic["description"]?.string,
                      let price = prodDic["price"]?.int,
                      let rating = prodDic["rating"]?.float else { fatalError("Problem with unwrapping in for loop ") }
                
                let newProduct = Product(id: id, title: title, description: description, price: price, rating: rating)
                DispatchQueue.main.async {
                    self?.products.append(newProduct)
                }
            }
        }
    }
}
