//
//  MainView.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import SwiftUI

struct MainView: View {
    @State private var cards: [Card] = []
    @State private var isLoading: Bool = true
    @State private var offset: Int = 0
    @State private var isRefreshing = false
    @State private var showAlert = false
    @State private var activeAlert: ErrorAlert = .auth
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !cards.isEmpty {
                    VStack {
                        ForEach(cards) { card in
                            CardView(card: card)
                                .cornerRadius(20)
                                .padding()
                        }
                    }
                }
            }
            .toolbar {
                Text("Управление картами")
                    .foregroundColor(Color(hex: CustomColors.blue))
                    .font(.title2)
                    .padding(.trailing, 80)
            }
            .background(Color(hex: CustomColors.lightGrey))
            .onAppear {
                NetworkService.fetchCompanies(offset: offset) { cards, errorCode, error in
                    if errorCode != nil {
                        switch errorCode {
                        case 401:
                            activeAlert = .auth
                            showAlert = true
                        case 400:
                            activeAlert = .message
                            guard let textError = error?.localizedDescription else { return }
                            errorMessage = textError
                            showAlert = true
                        case 500:
                            activeAlert = .down
                            showAlert = true
                        default:
                            return
                        }
                    } else {
                        guard let cards else { return }
                        self.cards = cards
                        isLoading = false
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                            switch activeAlert {
                            case .auth:
                                return Alert(title: Text("Error"),
                                             message: Text("Ошибка авторизации"),
                                             dismissButton: .default(Text("OK")))
                            case .message:
                                return Alert(title: Text("Error"),
                                             message: Text(errorMessage),
                                             dismissButton: .default(Text("OK")))
                            case .down:
                                return Alert(title: Text("Error"),
                                             message: Text("Все упало"),
                                             dismissButton: .default(Text("OK")))
                            }
            }
        }
        .overlay(isLoading ? ProgressView() : nil)
    }
}
