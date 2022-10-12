//
//  TwitterAPIClientWrapperStore.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import Foundation
import TwitterAPIKit

actor TwitterAPIClientWrapperStore {
    
    static let shared: TwitterAPIClientWrapperStore = .init()
    
    var accessToken: String {
        get {
            UserDefaults.standard.string(forKey: "accessToken") ?? ""
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    var refreshToken: String {
        get {
            UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "refreshToken")
        }
    }
    
    var client: TwitterAPIClient = TwitterAPIClient(
        .requestOAuth20WithPKCE(
            .confidentialClient(clientID: TWITTER_API.clientID,
                                clientSecret: TWITTER_API.clientSecret)
        )
    )
    
    private init() {}
    
    func update(token: TwitterOAuth2AccessToken) {
        // TODO: scopeなども諸々保存する
        accessToken = token.accessToken
        refreshToken = token.refreshToken ?? ""
                
        client = TwitterAPIClient(.oauth20(.init(
            clientID: TWITTER_API.clientID,
            scope: token.scope,
            tokenType: token.tokenType,
            expiresIn: token.expiresIn,
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )))
    }
    
}
