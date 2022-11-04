//
//  RequestManager.swift
//  CryptoRadar
//
//  Created by ale farina on 29/10/22.
//

import Foundation

protocol RequestMangerProtocol {
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestMangerProtocol {
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    
    init(apiManager: APIManagerProtocol = APIManager(), parser: DataParserProtocol = DataParser()) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.perform(request, authToken: "")
        
        let decoded: T = try parser.parse(data)
        
        return decoded
    }
    
}



