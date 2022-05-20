//
//  HeroesRequest.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 18.05.2022.
//

import Foundation

struct HeroesRequest: Request {
    
    private let publicKey = "e1f2b08c99f1aebfe4f2cfc7e3057c26"
    private let privateKey = "8c3f5bc06ceaa7d9d65a66cfce3aac2af8491216"
    private let offSet: Int
    
    private var timeStamp: String {
        return String(Int(Date().timeIntervalSince1970))
    }
    
    private var hash: String {
        let hashableString = timeStamp + privateKey + publicKey
        return hashableString.MD5()
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.port = 443
        
        components.path = "/v1/public/characters"
        
        let queryItems = [
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "orderBy", value: "name"),
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "offset", value: "\(offSet)")
        ]
        components.queryItems = queryItems
        
        return components.url
    }
    
    init(offSet: Int) {
        self.offSet = offSet
    }
    
}
