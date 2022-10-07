//
//  LoginViewModel.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/06.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    let dismiss: PassthroughSubject<Void, Never> = .init()
    
    func loginButtonPressed() async throws {
        TwitterAPIService.Login.shared.openLoginPage { code in
            Task {
                let response = try await TwitterAPIService.GetInitialToken.shared.getInitialToken(code: code)
                print("response.accessToken: \(response.accessToken)")
                print("response.refreshToken: \(response.refreshToken)")
            }
        } failure: {
            print("error")
        }
    }
}
