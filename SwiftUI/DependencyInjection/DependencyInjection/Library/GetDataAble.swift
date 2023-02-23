//
//  GetDataAble.swift
//  DependencyInjection
//
//  Created by Ivan Pryhara on 23.02.23.
//

import Foundation
import APIKit

protocol GetDataable {
    func getData(_ completion: @escaping (Data?) -> Void)
}

extension APIKitLoader: GetDataable { }
