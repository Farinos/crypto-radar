//
//  ContentView.swift
//  CryptoRadar
//
//  Created by ale farina on 29/10/22.
//

import SwiftUI

struct CryptoListView: View {
    @ObservedObject var vm: CryptoListViewModel = CryptoListViewModel()
    
    var body: some View {
        return NavigationView {
            switch vm.viewState {
            case .Init:
                return AnyView(Text(""))
            case .Fetching(_):
                return AnyView(Text("Loading"))
            case .SuccessFetching(_):
                return AnyView(ZStack {
                    Color.offWhite.ignoresSafeArea()
                    
                    ScrollView {
                        ForEach(vm.coins, id: \.name, content: { coin in
                            CryptoCard(model: CryptoCardModel.init(from: coin))
                        })
                        .padding()
                    }
                })
            case .ErrorFetching:
                return AnyView(Text("Error"))
            }
        }.task {
            await vm.fetchCrypto()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView()
    }
}

