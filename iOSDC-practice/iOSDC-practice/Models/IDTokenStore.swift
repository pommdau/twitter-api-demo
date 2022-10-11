//
//  IDTokenStore.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/22.
//

import Foundation

actor IDTokenStore {
    
    static let shared: IDTokenStore = .init()
    
    private init() {}
    
    var value: IDToken {
        get throws {
            let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
            let data: Data = try .init(contentsOf: url)
            let rawValue: String = .init(data: data, encoding: .utf8)!
            return IDToken(rawValue: rawValue)
        }
    }
    
    func update(_ value: IDToken) throws {
        let data = value.rawValue.data(using: .utf8)!
        let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
        try data.write(to: url, options: .atomic)
    }
}
