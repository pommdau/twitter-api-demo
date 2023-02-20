//
//  TwitterAPIService+TokenManager.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import Foundation
import TwitterAPIKit

extension TwitterAPIService {
    
    final actor OAuth20 {
        
        static let shared: OAuth20 = .init()
                                               
        func getInitialToken(code: String) async throws -> TwitterOAuth2AccessToken {
            try await withCheckedThrowingContinuation { continuation in
                getInitialToken(code: code) { result in
                    do {
                        let token = try result.get()
                        continuation.resume(returning: token)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
        
        private func getInitialToken(code: String,
                                     completion: @escaping (Result<TwitterOAuth2AccessToken, Error>) -> ()) {
            

            IKEHTwitterAPIClient.shared.client.auth.oauth20.postOAuth2AccessToken(
                .init(
                    code: code,
                    clientID: TWITTER_API.clientID,
                    redirectURI: TWITTER_API.callbackURL,
                    codeVerifier: TWITTER_API.codeVerifier
                )).responseObject { response in
                    do {
                        let token = try response.result.get()
                        completion(.success(token))
                    } catch {
                        completion(.failure(error))
                    }
                }
        }
    }
}
