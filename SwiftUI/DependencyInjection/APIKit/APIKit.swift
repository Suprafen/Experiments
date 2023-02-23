//
//  APIKit.swift
//  APIKit
//
//  Created by Ivan Pryhara on 23.02.23.
//

import Foundation

public class APIKitLoader {
    
    private var url: URL?
    
    public init(url: URL? = URL(string: "https://dummyjson.com/products")!) {
        self.url = url
    }
    
    public func getData(_ completion: @escaping (Data?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data, error == nil else {
                completion(nil)
                fatalError(error!.localizedDescription)
            }
            
            completion(data)
            
        }
        
        task.resume()
    }
    
}
