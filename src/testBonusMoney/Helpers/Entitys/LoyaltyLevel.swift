//
//  LoyaltyLevel.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 16.04.2023.
//

struct LoyaltyLevel: Codable {
    let cashToMark: Int
    let markToCash: Int
    let name: String
    let number: Int
    let requiredSum: Int
}
