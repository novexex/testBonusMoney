//
//  MainView.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 16.04.2023.
//

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
