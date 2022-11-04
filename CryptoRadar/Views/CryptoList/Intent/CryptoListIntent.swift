//
//  CryptoListIntent.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation
// TODO: - Review protocol
protocol CryptoListIntentProtocol {
    //func viewOnAppear()
    //func onTapUrlContent(id: String)
}


final class CryptoListIntent {
    private let service: RequestMangerProtocol
    private weak var model: CryptoListModelActionsProtocol?
    
    init(model: CryptoListModelActionsProtocol,
         service: RequestMangerProtocol) {
        self.model = model
        self.service = service
    }
    
    func fetchCrypto() async {
        model?.loading()
        
        do {
            let coins: [Coin] = try await service.perform(CoinGeckoRequest.getCoinsList(currency: "eur", perPage: "10", page: "1"))
            print(coins)
            model?.update(coins)
            
            
        } catch let error {
            model?.error(error)
        }
    }
}