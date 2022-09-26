//
//  LoginViewModel.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/22.
//

import Foundation
import Combine


@MainActor
final class LoginViewModel: ObservableObject {
    
    struct ErrorInfo {
        var isPresentingError = false
        var title = ""
        var message = ""
    }
    
    @Published var id: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoginButtonEnabled: Bool = true
    @Published var errorInfo = ErrorInfo()
        
    func loginButtonPressed() async -> Bool {
        isLoginButtonEnabled = false
        defer { isLoginButtonEnabled = true }
        do {
            try await AuthService.shared.logIn(for: .init(rawValue: id),
                                               with: password)
//            throw AuthAPIError.loginError  // デバッグ用
        } catch {
            // Error Handling
            // logger.warning("\(error)")
            switch error {
            case AuthAPIError.loginError:
                errorInfo = ErrorInfo(isPresentingError: true,
                                                        title: "ログインエラー",
                                                        message: "IDまたはパスワードが正しくありません")
            case AuthAPIError.unknown:
                errorInfo = ErrorInfo(isPresentingError: true,
                                                        title: "ログインエラー",
                                                        message: "不明なエラーが発生しました")
            default:
                errorInfo = ErrorInfo(isPresentingError: true,
                                                        title: "不明なエラー",
                                                        message: "不明なエラーが発生しました")
            }
            
            return false
        }
        
        return true
    }    
}
