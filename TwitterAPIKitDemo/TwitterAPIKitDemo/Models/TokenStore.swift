//
//  TokenStore.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import Foundation
import TwitterAPIKit

actor TokensStore {
    
    static let shared: TokensStore = .init()
    
    private init() {}
        
    var oAuth20: TwitterAuthenticationMethod.OAuth20? {
        get {
            guard let data = UserDefaults.standard.data(forKey: "oAuth20") else {
                return nil
            }
            return try? JSONDecoder().decode(TwitterAuthenticationMethod.OAuth20.self, from: data)
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "oAuth20")
        }
    }
}
