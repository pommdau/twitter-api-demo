//
//  TwitterAPIDemoTests.swift
//  TwitterAPIDemoTests
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import XCTest
@testable import TwitterAPIDemo

@MainActor
final class TwitterAPIDemoTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testLoginErrorMessageByLoginError() async {
        let viewModel: LoginViewModel<StubAuthService> = .init()
        await viewModel.loginButtonPressed()  // LoginError
        XCTAssertEqual(viewModel.errorWrapper.apiError, .login)
    }

}

private final class StubAuthService: AuthServiceProtocol {

    static var shared: StubAuthService = .init()
    private init() {}
    
    func logIn(for id: User.ID, with password: String) async throws {
        throw AuthAPIError.login
    }
    
}
