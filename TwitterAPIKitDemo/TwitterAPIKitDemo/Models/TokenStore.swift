//
//  TokenStore.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import Foundation
import TwitterAPIKit

actor OAuth20Store {
    
    static let shared: OAuth20Store = .init()
    
    private(set) var oAuth20: TwitterAuthenticationMethod.OAuth20? = nil
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: "oAuth20") {
            self.oAuth20 = try? JSONDecoder().decode(TwitterAuthenticationMethod.OAuth20.self, from: data)
        }
    }
            
    func update(withToken token: TwitterOAuth2AccessToken) {
        let newOAuth20: TwitterAuthenticationMethod.OAuth20 = .init(clientID: TWITTER_API.clientID,
                                                                    token: token)
        self.oAuth20 = newOAuth20
        UserDefaults.standard.set(newOAuth20, forKey: "oAuth20")
    }
}
