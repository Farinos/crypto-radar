//
//  CryptoListProtocol.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation

enum CryptoListViewState {
    case initial
    case loading(String)
    case fetched([Coin])
    case error(Error)
}

protocol CryptoListModelStatePotocol {
    var state: CryptoListViewState { get }
    var coins: [Coin] { get }
}

protocol CryptoListModelActionsProtocol: AnyObject {
    func loading()
    func update(_ coins: [Coin])
    func error(_ error: Error)
}
