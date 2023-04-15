//
//  CardView.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .eye
    
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
                Text("200")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("баллов")
                    .foregroundColor(Color(hex: ProjectColors.textColor))
                    .padding(.top, 5)
            }
            .padding(.vertical)
            
            HStack(spacing: 60) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Кэшбек")
                        .foregroundColor(Color(hex: ProjectColors.textColor))
                    Text("1%")
                        .font(.system(size: 22))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Уровень")
                        .foregroundColor(Color(hex: ProjectColors.textColor))
                    Text(decodeUnicodeString(card.customerMarkParameters.loyaltyLevel.name))
                        .font(.system(size: 22))
                }
            }
            .padding(.vertical)
            
            Divider()
            
            HStack {
                HStack(spacing: 50) {
                    Button(action: {
                        activeAlert = .eye
                        showAlert = true
                    }) {
                        Image("eye_white")
                            .resizable()
                            .colorMultiply(Color(hex: ProjectColors.mainColor))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(action: {
                        activeAlert = .trash
                        showAlert = true
                    }) {
                        Image("trash_white")
                            .resizable()
                            .colorMultiply(Color(hex: ProjectColors.accentColor))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button("Подробнее") {
                    activeAlert = .more
                    showAlert = true
                }
                .frame(width: 130)
                .padding()
                .foregroundColor(Color(hex: ProjectColors.mainColor))
                .background(Color(hex: ProjectColors.backgroundColor))
                .cornerRadius(20)
                .alert(isPresented: $showAlert) {
                                switch activeAlert {
                                case .eye:
                                    return Alert(title: Text("Eye button pressed"),
                                                 message: Text("companyID: \(card.company.companyId)"),
                                                 dismissButton: .default(Text("OK")))
                                case .trash:
                                    return Alert(title: Text("Trash button pressed"),
                                                 message: Text("companyID: \(card.company.companyId)"),
                                                 dismissButton: .default(Text("OK")))
                                case .more:
                                    return Alert(title: Text("More button pressed"),
                                                 message: Text("companyID: \(card.company.companyId)"),
                                                 dismissButton: .default(Text("OK")))
                                }
                }
            }
            
        }
        .padding()
        .background(Color(hex: ProjectColors.cardBackgroundColor))
    }
}
