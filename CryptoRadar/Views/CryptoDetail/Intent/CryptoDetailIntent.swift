//
//  CryptoDetailIntent.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation

protocol CryptoDetailIntentProtocol {
    //func viewOnAppear()
    //func onTapUrlContent(id: String)
}

final class CryptoDetailIntent {
    private let service: RequestMangerProtocol
    private weak var model: CryptoDetailModelActionsProtocol?
    private var id: String
    
    init(model: CryptoDetailModelActionsProtocol,
         service: RequestMangerProtocol,
         id: String) {
        self.id = id
        self.model = model
        self.service = service
    }
    
    func fetchDetail() async {
        model?.loading()
        
        do {
            let coin: CoinDetail = try await service.perform(CoinGeckoRequest.getDetail(coin: id))
            
            let marketData: CoinMarketData = try await service.perform(CoinGeckoRequest.getMarketChart(
                coin: id,
                currency: "eur",
                days: 7))

            model?.update(detail: coin, data: marketData)
            

        } catch let error {
            model?.error(error)
        }
    }
    
    
}
