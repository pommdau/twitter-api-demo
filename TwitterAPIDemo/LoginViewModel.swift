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
        var authServiceError: AuthServiceError? = nil
        var isPresentingError = false
    }
        
    @Published var id: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoginButtonEnabled: Bool = true
    @Published var errorWrapper = ErrorWrapper()
    
    let dismiss: PassthroughSubject<Void, Never> = .init()
    
    func loginButtonPressed() async {
        isLoginButtonEnabled = false
        defer { isLoginButtonEnabled = true }

        do {
            try await AuthService.shared.logIn(for: .init(rawValue: id),
                                               with: password)
//            throw AuthServiceError.unknown  // デバッグ用
            dismiss.send()
        } catch {
            guard let authServiceError = error as? AuthServiceError else {
                errorWrapper = ErrorWrapper(authServiceError: .others(error))
                return
            }
            errorWrapper = ErrorWrapper(authServiceError: authServiceError)
            return
        }
    }    
}
