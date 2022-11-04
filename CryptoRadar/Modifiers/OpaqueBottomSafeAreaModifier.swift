//
//  OpaqueBottomSafeAreaModifier.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import SwiftUI

struct OpaqueBottomSafeAreaModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                Color.clear
                    .frame(height: 5)
                    .background(Material.bar)
            }
    }
}

extension View {
    func opaqueBottomSafeArea() -> some View {
        modifier(OpaqueBottomSafeAreaModifier())
    }
}
