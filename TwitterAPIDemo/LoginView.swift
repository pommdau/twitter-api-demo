//
//  LoginView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import SwiftUI

enum AuthAPI {
    static func logIn(for id: User.ID,
                      with password: String) async throws -> IDToken {
        
        let url = URL(string: "https://www.google.co.jp/")!
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            print(error.localizedDescription)
        }
        
        return IDToken(rawValue: "sample_id_token")
    }
}

struct User: Identifiable, Sendable {
    let id: ID
    let nickname: String
    let birthday: Date
    
    struct ID: Hashable, Sendable {
        let rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

struct IDToken: Hashable, Sendable {
    let rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

struct LoginView: View {
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var isLoginButtonDisable = false
    @State private var isPresentingError = false
    
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
                            let idToken = try await AuthAPI.logIn(for: .init(rawValue: id),
                                                                  with: password)
                            
                            Task.detached {
                                let data = idToken.rawValue.data(using: .utf8)!
                                let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
                                try data.write(to: url, options: .atomic)
                            }
                        } catch {
                            // Error Handling
                        }
                        
                    }
                } label: {
                    Text("Log in")
                }
                .disabled(isLoginButtonDisable)

            }
            Spacer()
        }
        .alert("ログインエラー", isPresented: $isPresentingError) {
            Button("閉じる", action: {})
        } message: {
            Text("IDまたはパスワードが正しくありません。")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
