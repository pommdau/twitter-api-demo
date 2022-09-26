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
        
        StubAuthService.shared.logInResult = .failure(AuthAPIError.login)
        await viewModel.loginButtonPressed()  // LoginError
        XCTAssertEqual(viewModel.errorWrapper.apiError, .login)
    }
}
