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
        
        StubAuthService.shared.logInResult = .failure(AuthServiceError.login)
        await viewModel.loginButtonPressed()  // LoginError
                
        // [SwiftのEnumをif文で比較できない（Associated Value）](https://qiita.com/y_koh/items/204f04ab11677bd73444)
        guard case AuthServiceError.login = viewModel.errorWrapper.authServiceError! else {
            XCTFail()
            return
        }
    }
    
    // MARK: - LoginButton Tests
    
    func testLoginButtonEnabled() async {
        let viewModel: LoginViewModel<StubAuthService> = .init()
        StubAuthService.shared.logInResult = .success(())
        
        // ボタン押下前後の状態を確認
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
        // iosdcの動画が出たら確認する
//        async let logIn: Void = viewModel.loginButtonPressed()
//        XCTAssertFalse(viewModel.isLoginButtonEnabled)
//        await logIn
//        XCTAssertTrue(viewModel.isLoginButtonEnabled)
    }
}
