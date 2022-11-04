//
//  CryptoDetailProtocol.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation

enum CryptoDetailViewState {
    case initial
    case loading(String)
    case fetched(CoinDetail, CoinMarketData)
    case error(Error)
}

protocol CryptoDetailModelStateProtocol {
    var state: CryptoDetailViewState { get }
    var detail: CoinDetail? { get }
    var data: CoinMarketData? { get }
}

protocol CryptoDetailModelActionsProtocol: AnyObject {
    func loading()
    func update(detail: CoinDetail, data: CoinMarketData)
    func error(_ error: Error)
}
