//
//  TwitterAPIRequest+GetInitialToken.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

extension TwitterAPIRequest {
    
    struct GetInitialToken: TwitterAPIRequestProtocol {
        typealias Response = TwitterAPIResponse.GetInitialToken
        public let code: String
        
        // MARK: - Properties
        
        public var baseURL: URL {
            return URL(string: "https://api.twitter.com/2")!
        }
                                
        public var method: HTTPMethod {
            return .post
        }
        
        public var path: String {
            return "/oauth2/token"
        }
        
        public var queryItems: [URLQueryItem] {
            return []
        }
        
        public var header: Dictionary<String, String>? {
            return ["Content-Type": "application/json"]
        }
        
        public var body: Data? {
            let bodyJSON = [
                "code" : code,
                "grant_type" : "authorization_code",
                "client_id" : TWITTER_API.CLIENT_ID,
                "redirect_uri" : TWITTER_API.CALLBACKURL,
                "code_verifier" : "code_challenge",
            ]
            
            guard let bodyData = try? JSONSerialization.data(withJSONObject: bodyJSON) else {
                return nil
            }
            
            return bodyData
        }
    }
}
