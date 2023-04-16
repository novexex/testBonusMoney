//
//  MainView.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import SwiftUI

struct MainView: View {
    @State var cards: [Card] = []
    @State var isLoading: Bool = true
    @State var showAlert = false
    @State var activeAlert: ActiveAlert = .messageError
    @State var errorMessage = ""

    @State private var offset: Int = 0
    @State private var isRefreshing = false
    @State private var currentCard = Card()
    @State private var stopFetchData = false

    var body: some View {
        NavigationView {
            ScrollView {
                if !cards.isEmpty {
                    VStack {
                        ForEach(cards) {
                            CardView(card: $0,
                                     showAlert: $showAlert,
                                     activeAlert: $activeAlert,
                                     currentCard: $currentCard)
                                .cornerRadius(20)
                                .padding()
                        }
                    }
                }
            }
            // MARK: I couldn't pull to refresh at the bottom, so I left the default
            .refreshable {
                if !stopFetchData {
                    NetworkService.fetchCompanies(offset: offset) { cards, responseCode, error in
                        self.networkProcessing(cards, responseCode, error)
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
                NetworkService.fetchCompanies(offset: offset) { cards, responseCode, error in
                    self.networkProcessing(cards, responseCode, error)
                }
            }
            .alert(isPresented: $showAlert) {
                switch activeAlert {
                case .authError:
                    return Alert(title: Text("Error"),
                                 message: Text("Ошибка авторизации"),
                                 dismissButton: .default(Text("OK")))
                case .messageError:
                    return Alert(title: Text("Error"),
                                 message: Text(errorMessage),
                                 dismissButton: .default(Text("OK")))
                case .downError:
                    return Alert(title: Text("Error"),
                                 message: Text("Все упало"),
                                 dismissButton: .default(Text("OK")))
                case .eyeButton:
                    return Alert(title: Text("Eye button pressed"),
                                 message: Text("companyID: \(currentCard.company.companyId)"),
                                 dismissButton: .default(Text("OK")))
                case .trashButton:
                    return Alert(title: Text("Trash button pressed"),
                                 message: Text("companyID: \(currentCard.company.companyId)"),
                                 dismissButton: .default(Text("OK")))
                case .moreButton:
                    return Alert(title: Text("More button pressed"),
                                 message: Text("companyID: \(currentCard.company.companyId)"),
                                 dismissButton: .default(Text("OK")))
                }
            }
        }
        .overlay(isLoading ? ProgressView() : nil)
    }
}
