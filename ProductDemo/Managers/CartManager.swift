//
//  CartManager.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/25.
//

import UIKit

class CartManager {
    
    static let shared = CartManager()
    
    private(set) var products: [CategoryElement] = []
    
    private init() {}
    
    func addProductToCart(_ product: CategoryElement) {
        products.append(product)
        print("\(product.title) added to cart")
    }
    
}
