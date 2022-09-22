//
//  LoginView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import SwiftUI

struct LoginView: View {
    
    struct LoginViewErrorInfo {
        var isPresentingError = false
        var title = ""
        var message = ""
    }
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var isLoginButtonDisable = false
    @State private var loginViewErrorInfo = LoginViewErrorInfo()
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack {
                    TextField("ID", text: $id)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .frame(width: 200)
                Spacer()
                Button {
//                    isPresentingError.toggle()
                    // ログインのAPIをたたく
                    Task { @MainActor in
                        isLoginButtonDisable = true
                        defer { isLoginButtonDisable = false }
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
                } label: {
                    Text("Log in")
                }
                .disabled(isLoginButtonDisable)

            }
            Spacer()
        }
        .alert(loginViewErrorInfo.title, isPresented: $loginViewErrorInfo.isPresentingError) {
            Button("閉じる", action: {})
        } message: {
            Text(loginViewErrorInfo.message)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
