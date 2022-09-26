//
//  StubAuthService.swift
//  TwitterAPIDemoTests
//
//  Created by HIROKI IKEUCHI on 2022/09/26.
//

import Foundation
@testable import TwitterAPIDemo

final class StubAuthService: AuthServiceProtocol {

    static var shared: StubAuthService = .init()
    
    var logInResult: Result<Void, Error>?
    
    private init() {}
    
    func logIn(for id: User.ID, with password: String) async throws {
        try logInResult!.get()
    }
    
}
