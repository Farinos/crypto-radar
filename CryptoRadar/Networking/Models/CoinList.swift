//
//  CoinListModel.swift
//  CryptoRadar
//
//  Created by ale farina on 30/10/22.
//

import Foundation

struct Coin: Decodable {
    let id: String
    let name: String
    let image: URL
    let current_price: Double
}

struct CoinList: Decodable {
    let coins: [Coin]
}

