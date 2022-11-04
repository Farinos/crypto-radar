//
//  CryptoDetailView.swift
//  CryptoRadar
//
//  Created by ale farina on 01/11/22.
//

import SwiftUI

struct CryptoDetailView: View {
    @StateObject private var container: MVIContainer<CryptoDetailIntent, CryptoDetailModelStateProtocol>
        
    var body: some View {
        
        ZStack {
            Color.darkColor.ignoresSafeArea()
            
            switch container.model.state {
                
            case .fetched(let coin, let market):
                CryptoDetail(intent: container.intent, coin: coin, prices: market.prices)
                
            case .initial:
                Text("")
                
            case .loading(let text):
                LoadingView(text: text)
                
            case .error(let error):
                ErrorView(error: error, intent: container.intent)
            }
            
        }.task {
            await container.intent.fetchDetail()
        }
        
        
    }
}

// MARK: - Private structures
extension CryptoDetailView {
    private struct ErrorView: View {
        let error: Error
        let intent: CryptoDetailIntent
        
        var body: some View {
            VStack {
                Text(error.localizedDescription)
                Button(action: {
                    Task {
                        await intent.fetchDetail()
                    }
                }) {
                    Text("Riprova")
                }
            }
        }
    }
    
    private struct LoadingView: View {
        let text: String
        
        var body: some View {
            VStack {
                ProgressView {
                    Text(text)
                }
            }
        }
    }
    
    private struct CryptoDetail: View {
        var intent: CryptoDetailIntent
        var coin: CoinDetail
        var prices: [[Double]]
        
        @State var showDesc: Bool = false
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment:.leading, spacing: 5) {
                        Text(coin.name)
                            .foregroundColor(Color.offWhite)
                            .padding(.horizontal, 5)
                            .padding(.top, 10)
                            .font(.title.weight(.bold))
                        
                        if let url = URL(string: coin.links.homepage.first ?? "") {
                            Link(coin.links.homepage.first ?? "", destination: url)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 10)
                                .font(.caption).foregroundColor(.green)
                        }                        
                    }
                    .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 0,
                          maxHeight: .infinity,
                          alignment: .topLeading
                        )
                    .padding(.horizontal, 10)
                    .darkNeumorphicStyle()
                    
                    ChartView(vm: ChartViewModel(marketData: prices))
                   
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Info")
                            .font(.system(size: 12)
                                .weight(.bold))
                            .foregroundColor(.green)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                        
                        Text((coin.description["en"] ?? "").removingHTMLOccurances)
                            .lineLimit(showDesc ? nil : 4)
                            .font(.system(size: 14))
                            .foregroundColor(Color.offWhite).padding(.horizontal, 10).padding(.bottom, 6)
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                showDesc.toggle()
                            }
                        }, label: {
                            Text(showDesc ? "Show less" : "Show more...").font(.system(size: 10).weight(.semibold))
                                .padding(.vertical, 4).foregroundColor(Color.green)
                        }).padding(.horizontal, 10).padding(.bottom, 6)
                    }.darkNeumorphicStyle()
                    
                    
                    
                    Spacer()
                    
                    
                }.padding(.horizontal, 20).padding(.top, 10)
                    //.navigationTitle("CryptoRadar").navigationBarTitleDisplayMode(.inline)
            }.opaqueBottomSafeArea()
        }
    }
}


extension CryptoDetailView {
    static func build(_ id: String) -> some View {
        let model = CryptoDetailModel()
        let intent = CryptoDetailIntent(model: model, service: RequestManager(), id: id)
        
        let container = MVIContainer(
            intent: intent,
            model: model as CryptoDetailModelStateProtocol,
            modelChangePublisher: model.objectWillChange)
        
        return CryptoDetailView(container: container)
    }
}

struct CryptoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoDetailView.build("bitcoin")
    }
}
