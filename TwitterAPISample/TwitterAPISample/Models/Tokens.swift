//
//  Tokens.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/10.
//

import Foundation

struct AccessToken: Hashable, Sendable, Codable {
    let rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

struct RefreshToken: Hashable, Sendable, Codable {
    let rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

struct Tokens: Hashable, Sendable, Codable {
    let accessToken: AccessToken
    let refreshToken: RefreshToken
    
    init(accessToken: AccessToken, refreshToken: RefreshToken) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
