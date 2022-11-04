//
//  Extension+String.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation

enum RegEx: String {
    case htmlTag = "<[^>]+>"
}

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: RegEx.htmlTag.rawValue, with: "", options: .regularExpression, range: nil)
    }
}

