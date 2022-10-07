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
        
        func getInitialToken(code: String) async throws -> TwitterAPIResponse.GetInitialToken {
            return try await request(with: TwitterAPIRequest.GetInitialToken(code: code))
        }
    }
}
