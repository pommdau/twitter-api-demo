//
//  StubAuthService.swift
//  TwitterAPIDemoTests
//
//  Created by HIROKI IKEUCHI on 2022/09/26.
//

import Foundation
@testable import iOSDC_practice

final class StubAuthService: AuthServiceProtocol {

    static var shared: StubAuthService = .init()
    
    var logInContinuation: CheckedContinuation<Void, Error>?  
    
    private init() {}
    
    func logIn(for id: User.ID, with password: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            logInContinuation = continuation
        }
    }
    
}
