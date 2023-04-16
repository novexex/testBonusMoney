//
//  ImageView.swift
//  testBonusMoney
//
//  Created by Artour Ilyasov on 15.04.2023.
//

import SwiftUI

struct ImageView: View {
    var imageUrl: URL?
    
    var body: some View {
        AsyncImage(url: imageUrl) {
                $0
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
        }
    }
}
