//
//  CoinDetail.swift
//  CryptoRadar
//
//  Created by ale farina on 04/11/22.
//

import Foundation

struct Links: Codable {
    let homepage: [String]
}

struct CoinDetail: Decodable {
    let id: String
    let name: String
    let description: [String: String]
    let links: Links
}
