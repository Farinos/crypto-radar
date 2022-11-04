//
//  CryptoRadarApp.swift
//  CryptoRadar
//
//  Created by ale farina on 29/10/22.
//

import SwiftUI

@main
struct CryptoRadarApp: App {
    var body: some Scene {
        WindowGroup {
            CryptoListView.build()
        }
    }
}
