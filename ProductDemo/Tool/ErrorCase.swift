//
//  ErrorCase.swift
//  ProductDemo
//
//  Created by Tsai Ming Chen on 2024/9/16.
//

import Foundation

enum ErrorCase: String, Error {
    case unableGetCategories = "Unable get categories api."
    case invalidResponse    = "Invaid response from server."
    case invalidData        = "Invalid data from server."
}
