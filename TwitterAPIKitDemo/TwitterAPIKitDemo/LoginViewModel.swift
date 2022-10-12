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
    @Published var code: String = ""
    let dismiss: PassthroughSubject<Void, Never> = .init()
    let codeValueChanged: PassthroughSubject<String, Never> = .init()
    
    func loginButtonPressed() {
        TwitterAPIService.OAuth2.shared.openLoginPage { code in
            self.codeValueChanged.send(code)
        } failure: { errorMessage in
            self.errorWrapper = .init(title: "Login Error",
                                      guidance: errorMessage,
                                      isPresentingErrorView: true)
        }
    }
}
