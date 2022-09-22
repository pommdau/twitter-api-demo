//
//  AuthService.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/22.
//

import Foundation

actor AuthService {
    
    static let shared: AuthService = .init()
    
    private var isLoggingIn: Bool = false
    
    func logIn(for id: User.ID,
               with password: String) async throws {
        
        if isLoggingIn { return }
        isLoggingIn = true
        defer { isLoggingIn = false }
        
        let idToken = try await AuthAPI.logIn(for: id, with: password)
        try await IDTokenStore.shared.update(idToken)  // 中の処理はサブスレッドになる？
    }
}
