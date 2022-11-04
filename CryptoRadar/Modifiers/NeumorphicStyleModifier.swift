//
//  NeumorphicStyleModifier.swift
//  CryptoRadar
//
//  Created by ale farina on 03/11/22.
//

import SwiftUI

struct NeumorphicStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.darkColor)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 10, y: 10)
            .shadow(color: Color.shadowWhite.opacity(0.4), radius: 10, x: -5, y: -5)
    }
}


extension View {
    func darkNeumorphicStyle() -> some View {
        modifier(NeumorphicStyleModifier())
    }
}
