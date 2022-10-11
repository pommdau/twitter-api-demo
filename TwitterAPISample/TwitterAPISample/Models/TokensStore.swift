//
//  TokensStore.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/10.
//

import Foundation

actor TokensStore {
    
    static let shared: TokensStore = .init()
    static private let url: URL = .libraryDirectory.appendingPathComponent("TokensStore")
    
    private init() {}
    
    var tokens: Tokens {
        get throws {
            let data: Data = try .init(contentsOf: Self.url)
            return try JSONDecoder().decode(Tokens.self, from: data)
        }
    }
    
    func update(tokens: Tokens) throws {
        let data: Data = try JSONEncoder().encode(tokens)
        try data.write(to: Self.url, options: .atomic)
    }
}
