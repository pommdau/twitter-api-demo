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
    
    struct ErrorWrapper {

        var loginError: LoginError? = nil
        var isPresentingError = true

        var title: String {
            return "ログインエラー"
        }

        var message: String {
            guard let loginError = loginError else { return "" }
            switch loginError {
            case .login:
                return "IDまたはパスワードが正しくありません"
            case .network:
                return "ネットワークのエラーが発生しました"
            case .server:
                return "サーバーのエラーが発生しました"
            case .system:
                return "システムのエラーが発生しました"
            case .unknown:
                return "不明なエラーが発生しました"
            }
        }
    }
    
    enum LoginError: Hashable {
        case login
        case network
        case server
        case system
        case unknown
    }
    
    @Published var id: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoginButtonEnabled: Bool = true
    @Published var errorWrapper = ErrorWrapper(isPresentingError: false)
    
    let dismiss: PassthroughSubject<Void, Never> = .init()
    
    func loginButtonPressed() async {
        isLoginButtonEnabled = false
        defer { isLoginButtonEnabled = true }
        do {
            try await AuthService.shared.logIn(for: .init(rawValue: id),
                                               with: password)
//            throw AuthAPIError.loginError  // デバッグ用
            dismiss.send()
        } catch {
            // Error Handling
            // logger.warning("\(error)")
            switch error {
            case AuthAPIError.loginError:
                errorWrapper = ErrorWrapper(loginError: .login)
            default:
                errorWrapper = ErrorWrapper(loginError: .unknown)
            }
        }
    }    
}
