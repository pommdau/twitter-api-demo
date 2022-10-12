//
//  TwitterAPIService+Login.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/11.
//

import Foundation
import TwitterAPIKit
import UIKit
import CryptoKit

extension TwitterAPIService {
    
    final class OAuth2 {
        
        static let shared: OAuth2 = .init()
        
        private var client: TwitterAPIClient = TwitterAPIClient(
            .requestOAuth20WithPKCE(
                .confidentialClient(clientID: TWITTER_API.clientID,
                                    clientSecret: TWITTER_API.clientSecret)
            )
        )
        
        private var codeChallenge: String {
            // ref: https://developers.line.biz/ja/docs/line-login/integrate-pkce/#how-to-integrate-pkce
            Data(
                SHA256.hash(data: TWITTER_API.codeVerifier.data(using: .utf8)!)
            )
            .base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
        }
        
        private var authorizeURL: URL {
            get throws {
                return client.auth.oauth20.makeOAuth2AuthorizeURL(.init(
                    clientID: TWITTER_API.clientID,
                    redirectURI: TWITTER_API.callbackURL,
                    state: TWITTER_API.state,
                    codeChallenge: codeChallenge,
                    codeChallengeMethod: "S256", // OR S256
                    scopes: ["tweet.read", "tweet.write", "users.read", "offline.access"]
                ))!
            }
        }
                
        public func openLoginPage() {
            NotificationCenter.default.addObserver(self, selector: #selector(handleReceivingCallbackURL(_:)),
                                                   name: Notification.Name.receivedCallBackURL,
                                                   object: nil)
            UIApplication.shared.open(try! authorizeURL)
        }
        
        @objc func handleReceivingCallbackURL(_ notification: Notification) {
            NotificationCenter.default.removeObserver(self)
            
            guard let callbackURL = notification.userInfo?[NotificationUserinfoKeys.callbackURL] as? URL,
                  let queryItems = URLComponents(url: callbackURL , resolvingAgainstBaseURL: true)?.queryItems,
                  let code = queryItems.first(where: { $0.name == "code" })?.value,
                  let returnedState = queryItems.first(where: { $0.name == "state" })?.value
            else {
                print("Invalid return url")
                return
            }
            
            guard returnedState == TWITTER_API.state else {
                print("Invalid state", TWITTER_API.state, returnedState)
                return
            }
            
            print("Result: " + code)
                                    
            client.auth.oauth20.postOAuth2AccessToken(.init(
                code: code,
                clientID: TWITTER_API.clientID,
                redirectURI: TWITTER_API.callbackURL,
                codeVerifier: TWITTER_API.codeVerifier
            )).responseObject { response in
                do {
                    let tokens: TwitterOAuth2AccessToken = try response.result.get()
                    self.client = TwitterAPIClient(.oauth20(.init(
                        clientID: TWITTER_API.clientID,
                        scope: [],
                        tokenType: "",
                        expiresIn: 0,
                        accessToken: tokens.accessToken,
                        refreshToken: tokens.refreshToken
                    )))
//                    self.env.oauthToken = nil
//                    self.env.token = .init(clientID: clientID, token: token)
//                    self.env.store()
//                    self.showAlert(title: "Success!", message: nil) {
//                        self.navigationController?.popViewController(animated: true)
//                    }
                } catch let error {
//                    self.showAlert(title: "Error", message: error.localizedDescription)
                    print("stop")
                    print(error.localizedDescription)
                }
            }
            
//            let hoge = await client.v2.searchTweetsAll(.init(query: "マクドナルド")).responseObject

//            print(hoge)
        }
    }
}
