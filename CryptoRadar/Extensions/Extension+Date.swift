//
//  Extension+Date.swift
//  CryptoRadar
//
//  Created by ale farina on 03/11/22.
//

import Foundation

extension Date {
    // "01-01-22"
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
    
}
