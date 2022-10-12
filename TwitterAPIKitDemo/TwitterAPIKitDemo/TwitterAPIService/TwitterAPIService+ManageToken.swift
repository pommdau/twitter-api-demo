//
//  TwitterAPIService+TokenManager.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import Foundation
import TwitterAPIKit

extension TwitterAPIService {
    
    final actor TokenManager {
        
        static let shared: TokenManager = .init()
        
        var client: TwitterAPIClient = TwitterAPIClient(
            .requestOAuth20WithPKCE(
                .confidentialClient(clientID: TWITTER_API.clientID,
                                    clientSecret: TWITTER_API.clientSecret)
            )
        )
        
        func updateClient(withCode code: String) async throws {
            let token = try await getInitialToken(code: code)
            client = TwitterAPIClient(.oauth20(.init(
                clientID: TWITTER_API.clientID,
                scope: token.scope,
                tokenType: token.tokenType,
                expiresIn: token.expiresIn,
                accessToken: token.accessToken,
                refreshToken: token.refreshToken
            )))
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
        
        
        /*
        
        private func getInitialToken(code: String) async throws -> TwitterOAuth2AccessToken {
            try await withCheckedThrowingContinuation { continuation in
                await getInitialToken(code: code) { result in
                    do {
                        let token = try result.get()
                        continuation.resume(returning: token)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            
        }
        
        private func getInitialToken(code: String, completion: @escaping (Result<TwitterOAuth2AccessToken, Error>) -> ()) async {
            
            await TwitterAPIClientStore.shared.client.auth.oauth20.postOAuth2AccessToken(
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
         */
    }
}
