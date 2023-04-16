//
//  Card.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 16.04.2023.
//

extension Card: Identifiable {
    var id: String { company.companyId }
    
    init() {
        company = Company(companyId: "")
        customerMarkParameters = CustomerMarkParameters(loyaltyLevel: LoyaltyLevel(cashToMark: 0, markToCash: 0, name: "", number: 0, requiredSum: 0), mark: 0)
        mobileAppDashboard = MobileAppDashboard(accentColor: "", backgroundColor: "", cardBackgroundColor: "", companyName: "", highlightTextColor: "", logo: "", mainColor: "", textColor: "")
    }
}
