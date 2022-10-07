//
//  TwitterAPIRequest+Authentication.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

extension TwitterAPIRequest {
    
    // MARK: - ユーザ認証
    // ref: [Authentication](https://developer.twitter.com/en/docs/authentication/oauth-2-0/user-access-token)
    
    public struct Login: TwitterAPIRequestProtocol {
        public typealias Response = Bool  // 実際には不要
        
        // MARK: - Properties
        
        public var baseURL: URL {
            return URL(string: "https://twitter.com/i")!
        }
                                
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "/oauth2/authorize"
        }
        
        public var queryItems: [URLQueryItem] {
            
            // [Authentication>Scopes](https://developer.twitter.com/en/docs/authentication/oauth-2-0/authorization-code)
            let scope = [
                "tweet.read",
                "tweet.write",
                "users.read",
                "offline.access",
                "follows.read",
                "follows.write",
                "offline.access",
                "mute.read",
                "mute.write",
                "like.read",
                "like.write",
                "list.read",
                "list.write",
                "block.read",
                "block.write",
                "bookmark.read",
                "bookmark.write"
            ].joined(separator: " ")
            
            return [
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "client_id", value: TWITTER_API.CLIENT_ID),
                URLQueryItem(name: "redirect_uri", value: TWITTER_API.CALLBACKURL),
                URLQueryItem(name: "scope", value: scope),
                URLQueryItem(name: "state", value: "state"),
                URLQueryItem(name: "code_challenge", value: "code_challenge"),
                URLQueryItem(name: "code_challenge_method", value: "plain"),
            ]
        }
        
        public var header: Dictionary<String, String>? {
            return nil
        }
        
        public var body: Data? {
            return nil
        }
    }
    
}
