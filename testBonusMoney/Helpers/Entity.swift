//
//  Entity.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

struct Card: Codable, Identifiable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
    
    var id: String { company.companyId }
}

struct Company: Codable {
    let companyId: String
}

struct LoyaltyLevel: Codable {
    let cashToMark: Int
    let markToCash: Int
    let name: String
    let number: Int
    let requiredSum: Int
}

struct MobileAppDashboard: Codable {
    let accentColor: String
    let backgroundColor: String
    let cardBackgroundColor: String
    let companyName: String
    let highlightTextColor: String
    let logo: String
    let mainColor: String
    let textColor: String
}

struct CustomerMarkParameters: Codable {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}
