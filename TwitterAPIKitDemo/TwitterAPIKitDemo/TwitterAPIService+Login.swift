//
//  TwitterAPIService+Login.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/11.
//

import Foundation
import TwitterAPIKit
import UIKit

extension TwitterAPIService {
    
    final class Login {
        
        static let shared: Login = .init()
        
        private var client: TwitterAPIClient = TwitterAPIClient(
            .requestOAuth20WithPKCE(
                .confidentialClient(clientID: TWITTER_API.clientID,
                                    clientSecret: TWITTER_API.clientSecret)
            )
        )
        
        var authorizeURL: URL {
            get throws {
                return client.auth.oauth20.makeOAuth2AuthorizeURL(.init(
                    clientID: TWITTER_API.clientID,
                    redirectURI: TWITTER_API.callbackURL,
                    state: TWITTER_API.state,
                    codeChallenge: TWITTER_API.codeChallenge,
                    codeChallengeMethod: "plain", // OR S256
                    scopes: ["tweet.read", "tweet.write", "users.read", "offline.access"]
                ))!
            }
        }
                
        // MARK: - Login
        public func openLoginPage() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleReceivingCallbackURL(_:)),
                                                   name: Notification.Name.receivedCallBackURL,
                                                   object: nil)
            UIApplication.shared.open(try! authorizeURL)
        }
        
        @objc func handleReceivingCallbackURL(_ notification: Notification) {
            NotificationCenter.default.removeObserver(self)
            
            // DEBUGGING
//            failAuthentication()
//            return
            
            guard let callbackURL = notification.userInfo?[NotificationUserinfoKeys.callbackURL] as? URL,
                  let queryItems = URLComponents(url: callbackURL , resolvingAgainstBaseURL: true)?.queryItems
//                  let loginResponse = TwitterAPIResponse.Login(queryItems: queryItems)
            else {
//                failAuthentication()
                return
            }
//            successAuthentication(loginResponse.code)
            print("stop")
        }
    }
}
