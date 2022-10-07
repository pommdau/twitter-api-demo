//
//  TwitterAPIRequest+GetInitialToken.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation


extension TwitterAPIResponse {
    
    public struct GetInitialTokenResponse: Decodable {
        
        let accessToken: String
        let refreshToken: String
        
        public enum CodingKeys : String, CodingKey {
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
        }
    }

}

//Optional("[\"token_type\": bearer, \"expires_in\": 7200, \"access_token\": VHNvaFhEdkdzd3lsWFNTdWRxb1hlY2E1OXAtZnlBbXQ1MlFNMWFfU2UwSzM2OjE2NDk3NDUzODI0NDM6MTowOmF0OjE, \"scope\": mute.write block.read follows.read offline.access list.write bookmark.read list.read tweet.write block.write like.write like.read users.read tweet.read bookmark.write mute.read follows.write, \"refresh_token\": ZkxVeU5UZG1XcU9iOWgtazdiQkxhXzJzcVNEUVl3Tkc4ZzlNT3k3TjNSZGI5OjE2NDk3NDUzODI0NDM6MToxOnJ0OjE]")
