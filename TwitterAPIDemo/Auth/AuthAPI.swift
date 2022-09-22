//
//  AuthAPI.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/22.
//

import Foundation

enum AuthAPIError: Error {
    case loginError
    case unknown
}

enum AuthAPI {
    static func logIn(for id: User.ID,
                      with password: String) async throws -> IDToken {
        
        let url = URL(string: "https://www.google.co.jp/")!
        let request = URLRequest(url: url)
        
        do {
            // DEMO
            let (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            print(error.localizedDescription)
        }
        
        return IDToken(rawValue: "sample_id_token")
    }
}
