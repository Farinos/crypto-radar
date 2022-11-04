//
//  ErrorView.swift
//  CryptoRadar
//
//  Created by ale farina on 04/11/22.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let action: (() async -> ())?
    
    var body: some View {
        VStack(spacing: 10) {
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: {
                Task {
                    await action?()
                }
            }) {
                Text("Retry").foregroundColor(.green)
            }
        }
    }
}
