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
        
    func testLoginErrorMessageByUnknownError() async {
        let viewModel: LoginViewModel<StubAuthService> = .init()
        
        StubAuthService.shared.logInResult = .failure(AuthServiceError.unknown)
        await viewModel.loginButtonPressed()  // LoginError
        
        guard case AuthServiceError.unknown = viewModel.errorWrapper.authServiceError else {
            XCTFail()
            return
        }
    }
}
