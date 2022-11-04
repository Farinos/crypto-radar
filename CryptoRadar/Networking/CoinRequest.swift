//
//  CoinRequest.swift
//  CryptoRadar
//
//  Created by ale farina on 30/10/22.
//

import Foundation

enum CoinGeckoRequest: RequestProtocol {
    case getCoinsList(currency: String, perPage: String, page: String)
    case getDetail(coin: String)
    case getMarketChart(coin: String, currency: String, days: Int)
    
    var path: String {
        let pt = "/api/v3/coins"
        
        switch self {
        case .getCoinsList(_, _, _):
            return pt + "/markets"
            
        case let .getDetail(coin):
            return pt + "/" + coin
        
        case let .getMarketChart(coin, _, _):
            return pt + "/" + coin + "/" + "market_chart"
        }
        
        
    }
    
    var urlParams: [String : String?] {
        switch self {
        
        case let .getCoinsList(currency, perPage, page):
            return ["vs_currency": currency, "per_page": perPage, "page": page]
            
        case .getDetail(_):
            return [:]
            
        case let .getMarketChart(_, currency, days):
            return ["vs_currency": currency, "days": "\(days)"]
            
        }
    }
    
    var requestType: RequestType {
        .GET
    }
    
    
}
