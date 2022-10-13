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

struct IKEHTwitterAPIClient {
    
    static let shared: IKEHTwitterAPIClient = .init()
    
    var client: TwitterAPIClient = TwitterAPIClient(
        .requestOAuth20WithPKCE(
            .confidentialClient(clientID: TWITTER_API.clientID,
                                clientSecret: TWITTER_API.clientSecret)
        )
    )
}

extension TwitterAPIService {
    
    final class OAuth20Login {
        
        static let shared: OAuth20Login = .init()
        
        private var successAuthentication: (String) -> Void = {_ in}
        private var failAuthentication: (String) -> Void = {_ in}
        
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
                return IKEHTwitterAPIClient.shared.client.auth.oauth20.makeOAuth2AuthorizeURL(.init(
                    clientID: TWITTER_API.clientID,
                    redirectURI: TWITTER_API.callbackURL,
                    state: TWITTER_API.state,
                    codeChallenge: codeChallenge,
                    codeChallengeMethod: "S256", // "plain" OR "S256"
                    scopes: ["tweet.read", "tweet.write", "users.read", "offline.access"]
                ))!
            }
        }
        
        public func openLoginPage(success: @escaping (String) -> Void = {_ in},
                                  failure: @escaping (String) -> Void = {_ in}) {
            successAuthentication = success
            failAuthentication = failure
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleReceivingCallbackURL(_:)),
                                                   name: Notification.Name.receivedCallBackURL,
                                                   object: nil)
            UIApplication.shared.open(try! authorizeURL)
        }
        
        @objc private func handleReceivingCallbackURL(_ notification: Notification) {
            NotificationCenter.default.removeObserver(self)
            
            guard let callbackURL = notification.userInfo?[NotificationUserinfoKeys.callbackURL] as? URL,
                  let queryItems = URLComponents(url: callbackURL , resolvingAgainstBaseURL: true)?.queryItems,
                  let code = queryItems.first(where: { $0.name == "code" })?.value,
                  let returnedState = queryItems.first(where: { $0.name == "state" })?.value
            else {
                print("Invalid return url")
                failAuthentication("Invalid return url")
                return
            }
            
            guard returnedState == TWITTER_API.state else {
                print("Invalid state", TWITTER_API.state, returnedState)
                failAuthentication("Invalid state")
                return
            }
            
            // DEBUGGING
            //            failAuthentication("sample error")
            //            return;
            
            successAuthentication(code)
                
            IKEHTwitterAPIClient.shared.client.auth.oauth20.postOAuth2AccessToken(.init(
                code: code,
                clientID: TWITTER_API.clientID,
                redirectURI: TWITTER_API.callbackURL,
                codeVerifier: TWITTER_API.codeVerifier
            )).responseObject { response in
                do {
                    let tokens: TwitterOAuth2AccessToken = try response.result.get()
                    print(tokens.refreshToken)
                } catch let error {

                    print("stop")
                    print(error.localizedDescription)
                }
            }
            
        }
        
    }
}
