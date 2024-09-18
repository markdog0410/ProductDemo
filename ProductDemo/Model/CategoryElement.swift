//
//  Categories.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/16.
//

import Foundation

struct CategoryElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}
