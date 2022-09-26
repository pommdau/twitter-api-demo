//
//  LoginViewModel.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/22.
//

import Foundation
import Combine


@MainActor
final class LoginViewModel<AuthService>: ObservableObject where AuthService: AuthServiceProtocol {
    
    struct ErrorWrapper {
        var apiError: AuthAPIError = .unknown
        var isPresentingError = true
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
            switch error {
            case let apiError as AuthAPIError:
                errorWrapper = .init(apiError: apiError)
            default:
                errorWrapper = .init(apiError: .unknown)
            }
        }
    }    
}
