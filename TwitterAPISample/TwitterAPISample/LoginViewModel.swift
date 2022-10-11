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
    
    struct ErrorWrapper {
        var title: String = ""
        var guidance: String = ""
        var isPresentingErrorView = false
    }
    
    @Published var errorWrapper: ErrorWrapper = .init()
    let dismiss: PassthroughSubject<Void, Never> = .init()
    
    func loginButtonPressed() async throws {
        TwitterAPIService.Login.shared.openLoginPage { code in
            Task {
                let response = try await TwitterAPIService.GetInitialToken.shared.getInitialToken(code: code)
                print("response.accessToken: \(response.accessToken)")
                print("response.refreshToken: \(response.refreshToken)")
                self.dismiss.send()
            }
        } failure: {
            self.errorWrapper = .init(title: "ログイン処理でエラーが発生しました",
                                      guidance: "コールバックURLのデコードに失敗しました",
                                 isPresentingErrorView: true)
        }
    }
}
