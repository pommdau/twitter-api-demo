//
//  LoginViewModel.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    struct ErrorWrapper {
        var title: String = ""
        var guidance: String = ""
        var isPresentingErrorView = false
    }
    
    @Published var errorWrapper: ErrorWrapper = .init()
    @AppStorage("code") var code: String = ""
    let dismiss: PassthroughSubject<Void, Never> = .init()
    let codeValueChanged: PassthroughSubject<Void, Never> = .init()
    
    func loginButtonPressed() {
        TwitterAPIService.OAuth20Login.shared.openLoginPage { code in
            self.code = code
            self.codeValueChanged.send()
//            self.dismiss.send()
        } failure: { errorMessage in
            self.errorWrapper = .init(title: "Login Error",
                                      guidance: errorMessage,
                                      isPresentingErrorView: true)
        }
    }
    
    func getInitialTokenButtonPressed() async throws {
        do {
            try await TwitterAPIService.OAuth20.shared.updateToken(withCode: code)
        } catch {
            print(error.localizedDescription)
        }
    }
}
