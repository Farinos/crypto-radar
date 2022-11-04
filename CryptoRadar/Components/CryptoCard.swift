//
//  CryptoCard.swift
//  CryptoRadar
//
//  Created by ale farina on 31/10/22.
//

import SwiftUI

struct CryptoCardModel {
    let urlImage: URL
    let cryptoName: String
    let crypyoPrice: Double
    
    init(urlImage: URL, cryptoName: String, crypyoPrice: Double) {
        self.urlImage = urlImage
        self.cryptoName = cryptoName
        self.crypyoPrice = crypyoPrice
    }
    
    init(from coin: Coin) {
        self.urlImage = coin.image
        self.cryptoName = coin.name
        self.crypyoPrice = coin.current_price
    }
}

struct CryptoCard: View {
    var model: CryptoCardModel
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: model.urlImage) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                } placeholder: {
                    Circle()
                        .foregroundColor(Color.darkColor).shadow(color: Color.black.opacity(0.2), radius: 11, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 8, x: -5, y: -5)
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(model.cryptoName).bold()
                        .foregroundColor(Color.offWhite)
                    
                    Text("\(model.crypyoPrice)" + " €")
                        .font(.caption)
                        .foregroundColor(Color.offWhite)
                }
                Spacer()
            }.padding(.horizontal, 30)
        }
        .frame(minHeight: 100)
        .darkNeumorphicStyle()
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        
    }
}

struct CryptoCard_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCard(model: CryptoCardModel(urlImage:  URL(string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579")!,
                                          cryptoName: "Bitcoin",
                                          crypyoPrice: 35000))
    }
}

