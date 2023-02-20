//
//  TwitterAPIDemoTests.swift
//  TwitterAPIDemoTests
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import XCTest
@testable import iOSDC_practice

@MainActor
final class TwitterAPIDemoTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
     
    // MARK: - API Test
    
    func testLoginErrorMessageByLoginError() async {
        let viewModel: LoginViewModel<StubAuthService> = .init()
        
        async let logIn: Void = viewModel.loginButtonPressed()
        while StubAuthService.shared.logInContinuation == nil {
            await Task.yield()
        }
        StubAuthService.shared.logInContinuation?.resume(throwing: AuthServiceError.login)
        StubAuthService.shared.logInContinuation = nil
        await logIn
                
        // [SwiftのEnumをif文で比較できない（Associated Value）](https://qiita.com/y_koh/items/204f04ab11677bd73444)
        guard case AuthServiceError.login = viewModel.errorWrapper.authServiceError! else {
            XCTFail()
            return
        }
    }
    
    // MARK: - LoginButton Tests
    
    func testLoginButtonEnabled() async {
        let viewModel: LoginViewModel<StubAuthService> = .init()
        
        // ボタン押下前後の状態を確認
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
        
        async let logIn: Void = viewModel.loginButtonPressed()
        // loginButtonPressedの処理を待つためのwait
        while StubAuthService.shared.logInContinuation == nil {
            await Task.yield()
        }
        
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
        StubAuthService.shared.logInContinuation?.resume(returning: ())
        StubAuthService.shared.logInContinuation = nil
        await logIn
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
    }
}
