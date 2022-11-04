//
//  CryptoDetailModel.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation

final class CryptoDetailModel: ObservableObject, CryptoDetailModelStateProtocol {
    @Published var state: CryptoDetailViewState = .initial
    
    var detail: CoinDetail?
    var data: CoinMarketData?
    
}

extension CryptoDetailModel: CryptoDetailModelActionsProtocol {
    func loading() {
        state = .loading("loading")
    }
    
    func update(detail: CoinDetail, data: CoinMarketData) {
        self.detail = detail
        self.data = data
        
        state = .fetched(detail, data)
    }
    
    func error(_ error: Error) {
        state = .error(error)
    }
}

