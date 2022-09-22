//
//  LoginViewModel.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/22.
//

import Foundation
import Combine

struct LoginViewErrorInfo {
    var isPresentingError = false
    var title = ""
    var message = ""
}

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoginButtonEnabled: Bool = true
    @Published var loginViewErrorInfo = LoginViewErrorInfo()
        
    func loginButtonPressed() async {
        isLoginButtonEnabled = false
        defer { isLoginButtonEnabled = true }
        do {
            try await AuthService.shared.logIn(for: .init(rawValue: id),
                                               with: password)
            throw AuthAPIError.loginError
            // parent?.dismiss(animated: true)  // ログイン画面を閉じる
        } catch {
            // Error Handling
            // logger.warning("\(error)")
            switch error {
            case AuthAPIError.loginError:
                loginViewErrorInfo = LoginViewErrorInfo(isPresentingError: true,
                                                        title: "ログインエラー",
                                                        message: "IDまたはパスワードが正しくありません")
            case AuthAPIError.unknown:
                loginViewErrorInfo = LoginViewErrorInfo(isPresentingError: true,
                                                        title: "ログインエラー",
                                                        message: "不明なエラーが発生しました")
            default:
                loginViewErrorInfo = LoginViewErrorInfo(isPresentingError: true,
                                                        title: "不明なエラー",
                                                        message: "不明なエラーが発生しました")
            }
        }
    }
    
}
