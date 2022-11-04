//
//  LoadingView.swift
//  CryptoRadar
//
//  Created by ale farina on 04/11/22.
//

import SwiftUI

struct LoadingView: View {
    let text: String
    
    var body: some View {
        VStack {
            ProgressView {
                Text(text)
                    .foregroundColor(.green)
            }
        }
    }
}
