//
//  Product.swift
//  DependencyInjection
//
//  Created by Ivan Pryhara on 23.02.23.
//

import Foundation

class Product: Identifiable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var rating: Float
    
    init(id: Int, title: String, description: String,price: Int, rating: Float) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.rating = rating
    }
    
}
