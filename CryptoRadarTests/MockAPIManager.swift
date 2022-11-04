//
//  MockAPIManager.swift
//  CryptoRadarTests
//
//  Created by ale farina on 04/11/22.
//

import Foundation

class MockAPIManager: APIManagerProtocol, Mockable {
    
    /// Mocked API for load data from JSON file
    
    func perform(_ request: RequestProtocol, authToken: String = "") async throws -> Data {
        if request.path.split(separator: "/").last == "markets" {
            let data = loadJSON(filename: "CoinListResponse", type: [Coin].self)
            return data
            
        } else if request.path.split(separator: "/").last == "market_chart" {
            let data = loadJSON(filename: "CoinMarketDataResponse", type: CoinMarketData.self)
            return data
            
        } else {
            let data = loadJSON(filename: "CoinDetailResponse", type: CoinDetail.self)
            return data
        }
    }
}
