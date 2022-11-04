//
//  DataParser.swift
//  CryptoRadar
//
//  Created by ale farina on 29/10/22.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(_ data: Data) throws -> T
}

class DataParser: DataParserProtocol {
    func parse<T: Decodable>(_ data: Data) throws -> T {
        
        do {
            let element = try JSONDecoder().decode(T.self, from: data)
         
            return element
            
        } catch let error {
            print(error)
            throw NetworkError.parsingError
        }
    }
}
