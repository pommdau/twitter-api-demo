//
//  TwitterService+GetInitialToken.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import Foundation

extension TwitterAPIService {
    
    final class GetInitialToken: TwitterServiceProtocol {
        
        static let shared: GetInitialToken = .init()
        
        @discardableResult
        func getInitialToken(code: String) async throws -> TwitterAPIResponse.GetInitialToken {
            let response =  try await request(with: TwitterAPIRequest.GetInitialToken(code: code))
            try await TokensStore.shared.update(tokens: Tokens(accessToken: AccessToken(rawValue: response.accessToken),
                                                               refreshToken: RefreshToken(rawValue: response.refreshToken)))
            return response
        }
    }
}
