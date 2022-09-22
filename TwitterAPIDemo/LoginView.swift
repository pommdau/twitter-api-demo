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
            // DEMO
            let (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            print(error.localizedDescription)
        }
        
        return IDToken(rawValue: "sample_id_token")
    }
}

actor AuthService {
    
    static let shared: AuthService = .init()
    
    private var isLoggingIn: Bool = false
    
    func logIn(for id: User.ID,
               with password: String) async throws {
        
        if isLoggingIn { return }
        isLoggingIn = true
        defer { isLoggingIn = false }
        
        let idToken = try await AuthAPI.logIn(for: id, with: password)
        try await IDTokenStore.shared.update(idToken)  // 中の処理はサブスレッドになる？
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

actor IDTokenStore {
    
    static let shared: IDTokenStore = .init()
    
    private init() {}
    
    var value: IDToken {
        get throws {
            let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
            let data: Data = try .init(contentsOf: url)
            let rawValue: String = .init(data: data, encoding: .utf8)!
            return IDToken(rawValue: rawValue)
        }
    }
    
    func update(_ value: IDToken) throws {
        let data = value.rawValue.data(using: .utf8)!
        let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
        try data.write(to: url, options: .atomic)
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
                            try await AuthService.shared.logIn(for: .init(rawValue: id),
                                                               with: password)
                            // parent?.dismiss(animated: true)  // ログイン画面を閉じる
                        } catch {
                            // Error Handling
                            // logger.warning("\(error)")
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
