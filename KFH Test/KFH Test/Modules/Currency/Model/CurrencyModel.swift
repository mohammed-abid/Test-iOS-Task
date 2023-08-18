//
//  CurrencyModel.swift
//  KFH Test
//
//  Created by Mohammed Abid on 8/15/23.
//

import Foundation

// MARK: - Welcome
struct Currency: Codable {
    let base, date: String
    let rates: [String: Double]
    let success: Bool
    let timestamp: Int
}



