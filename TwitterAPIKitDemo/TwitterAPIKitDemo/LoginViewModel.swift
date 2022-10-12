//
//  LoginViewModel.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    struct ErrorWrapper {
        var title: String = ""
        var guidance: String = ""
        var isPresentingErrorView = false
    }
    
    @Published var errorWrapper: ErrorWrapper = .init()
    let dismiss: PassthroughSubject<Void, Never> = .init()
    
    func loginButtonPressed() async throws {
        
        TwitterAPIService.OAuth2.shared.openLoginPage { code in
            print(code)
        } failure: { errorMessage in
            self.errorWrapper = .init(title: "Login Error",
                                      guidance: errorMessage,
                                      isPresentingErrorView: true)
        }
    }
}
