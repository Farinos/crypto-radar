//
//  Mockable.swift
//  CryptoRadarTests
//
//  Created by ale farina on 04/11/22.
//

import Foundation
import CryptoRadar

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> Data
}

extension Mockable {
    var bundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> Data {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load json")
        }
        
        do {
            let data = try Data(contentsOf: path)
            return data
            
        } catch {
            fatalError("Failed to load json")
        }
    }
}
