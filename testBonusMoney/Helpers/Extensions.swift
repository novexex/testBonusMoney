//
//  Extensions.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue >> 16) & 0xFF) / 255.0
        let g = Double((rgbValue >> 8) & 0xFF) / 255.0
        let b = Double(rgbValue & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

extension Card: Identifiable, Equatable {
    var id: String { company.companyId }
    
    init() {
        company = Company(companyId: "")
        customerMarkParameters = CustomerMarkParameters(loyaltyLevel: LoyaltyLevel(cashToMark: 0, markToCash: 0, name: "", number: 0, requiredSum: 0), mark: 0)
        mobileAppDashboard = MobileAppDashboard(accentColor: "", backgroundColor: "", cardBackgroundColor: "", companyName: "", highlightTextColor: "", logo: "", mainColor: "", textColor: "")
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.company.companyId == rhs.company.companyId
    }
}

extension MainView {
    func networkProcessing(_ cards: [Card]?, _ responseCode: Int?, _ error: Error?) {
        if responseCode != nil {
            switch responseCode {
            case 401:
                activeAlert = .authError
                showAlert = true
            case 400:
                activeAlert = .messageError
                guard let textError = error?.localizedDescription else { return }
                errorMessage = textError
                showAlert = true
            case 500:
                activeAlert = .downError
                showAlert = true
            default:
                return
            }
        } else {
            guard let cards else { return }
            self.cards += cards
            isLoading = false
        }
    }
}
