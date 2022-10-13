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

        func updateToken(withCode code: String) async throws {
            let token: TwitterOAuth2AccessToken = try await getInitialToken(code: code)
            await OAuth20Store.shared.update(withToken: token)
        }
        
        private func getInitialToken(code: String) async throws -> TwitterOAuth2AccessToken {
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
        
        private func getInitialToken(code: String, completion: @escaping (Result<TwitterOAuth2AccessToken, Error>) -> ()) {
            
            let client: TwitterAPIClient = TwitterAPIClient(
                .requestOAuth20WithPKCE(
                    .confidentialClient(clientID: TWITTER_API.clientID,
                                        clientSecret: TWITTER_API.clientSecret)
                )
            )
            
            client.auth.oauth20.postOAuth2AccessToken(
                .init(
                    code: code,
                    clientID: TWITTER_API.clientID,
                    redirectURI: TWITTER_API.callbackURL,
                    codeVerifier: TWITTER_API.codeVerifier
                )).responseObject { response in
                    do {
                        let token: TwitterOAuth2AccessToken = try response.result.get()
                        completion(.success(token))
                    } catch {
                        completion(.failure(error))
                    }
                }
        }
    }
}
