//
//  CardView.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    @Binding var showAlert: Bool
    @Binding var activeAlert: ActiveAlert
    @Binding var currentCard: Card
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(decodeUnicodeString(card.mobileAppDashboard.companyName))
                    .font(.title)
                    .fontWeight(.light)
                
                Spacer()
                
                ImageView(imageUrl: getUrl(string: card.mobileAppDashboard.logo))
            }
            
            Divider()
            
            HStack {
                Text("\(card.customerMarkParameters.mark)")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("баллов")
                    .foregroundColor(Color(hex: card.mobileAppDashboard.textColor))
                    .padding(.top, 5)
            }
            .padding(.vertical)
            
            HStack(spacing: 60) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Кэшбек")
                        .foregroundColor(Color(hex: card.mobileAppDashboard.textColor))
                    Text("\(card.customerMarkParameters.loyaltyLevel.number)")
                        .font(.system(size: 22))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Уровень")
                        .foregroundColor(Color(hex: card.mobileAppDashboard.textColor))
                    Text(decodeUnicodeString(card.customerMarkParameters.loyaltyLevel.name))
                        .font(.system(size: 22))
                }
            }
            .padding(.vertical)
            
            Divider()
            
            HStack {
                HStack(spacing: 50) {
                    Button(action: {
                        activeAlert = .eyeButton
                        currentCard = card
                        showAlert = true
                    }) {
                        Image("eye_white")
                            .resizable()
                            .colorMultiply(Color(hex: card.mobileAppDashboard.mainColor))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(action: {
                        activeAlert = .trashButton
                        currentCard = card
                        showAlert = true
                    }) {
                        Image("trash_white")
                            .resizable()
                            .colorMultiply(Color(hex: card.mobileAppDashboard.accentColor))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button("Подробнее") {
                    activeAlert = .moreButton
                    currentCard = card
                    showAlert = true
                }
                .frame(width: 130)
                .padding()
                .foregroundColor(Color(hex: card.mobileAppDashboard.mainColor))
                .background(Color(hex: card.mobileAppDashboard.backgroundColor))
                .cornerRadius(20)
            }
            
        }
        .padding()
        .background(Color(hex: card.mobileAppDashboard.cardBackgroundColor))
    }
}
