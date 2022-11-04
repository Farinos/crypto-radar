//
//  RequestProtocol.swift
//  CryptoRadar
//
//  Created by ale farina on 29/10/22.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case parsingError
}

protocol RequestProtocol {
    var path: String { get }
    
    var addAuthorizationToken: Bool { get }
    
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    
    var urlParams: [String: String?] { get }
    
    var requestType: RequestType { get }
    
}

extension RequestProtocol {
    var host: String {
        "api.coingecko.com"
    }
    
    var addAuthorizationToken: Bool {
        false
    }
    
    var parameters: [String: Any] {
        [:]
    }
    
    var urlParams: [String: String?] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    func createURLRequest(authToken: String) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = components.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if addAuthorizationToken {
            urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !parameters.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        }
        
        return urlRequest
        
    }
}

