//
//  CryptoListModel.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation

final class CryptoListModel: ObservableObject, CryptoListModelStatePotocol {
    @Published var state: CryptoListViewState = .initial
    
    var coins: [Coin] = []
}

extension CryptoListModel: CryptoListModelActionsProtocol {
    func loading() {
        state = .loading("loading")
    }
    
    func update(_ coins: [Coin]) {
        self.coins = coins
        
        state = .fetched(coins)
    }
    
    func error(_ error: Error) {
        state = .error(error)
    }
}
