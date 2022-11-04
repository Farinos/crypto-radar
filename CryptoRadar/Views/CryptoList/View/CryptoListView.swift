//
//  ContentView.swift
//  CryptoRadar
//
//  Created by ale farina on 29/10/22.
//

import SwiftUI

struct CryptoListView: View {
    @StateObject private var container: MVIContainer<CryptoListIntent, CryptoListModelStatePotocol>
    
    var body: some View {
        return NavigationView {
            ZStack {
                Color.darkColor.ignoresSafeArea()
                
                switch container.model.state {
                    
                case .initial:
                    CryptoList(coins: [], intent: container.intent)
                    
                case .loading(let text):
                    LoadingView(text: text)
                    
                case let .fetched(coins):
                    CryptoList(coins: coins, intent: container.intent)
                    
                case let .error(error):
                    ErrorView(error: error) {
                        await container.intent.fetchCrypto()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .task {
                await container.intent.fetchCrypto()
            }
        }.accentColor(.green)
            .onAppear {
            self.setupNavigationBar()
        }
    }
}

extension View {
    func setupNavigationBar() {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.shadowColor = .white
        navigationAppearance.backgroundColor = UIColor(Color.darkColor)
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        
    }
}

// MARK: - Private structures
extension CryptoListView {
    private struct CryptoList: View {
        var coins: [Coin]
        var intent: CryptoListIntent
        
        var body: some View {
            ScrollView {
                ForEach(coins, id: \.id, content: { coin in
                    NavigationLink {
                        CryptoDetailView.build(coin.id)
                    } label: {
                        CryptoCard(model: CryptoCardModel.init(from: coin))
                    }.tint(.black)
                })
                .padding(.horizontal)
            }.opaqueBottomSafeArea()
        }
    }
}

// MARK: - Static functions
extension CryptoListView {
    
    static func build() -> some View {
        let model = CryptoListModel()
        let intent = CryptoListIntent(model: model, service: RequestManager())
        
        let container = MVIContainer(
            intent: intent,
            model: model as CryptoListModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        
        return CryptoListView(container: container)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView.build()
    }
}

