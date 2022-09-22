//
//  LoginView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import SwiftUI

struct LoginView: View {
        
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var isLoginButtonDisable = false
    @ObservedObject private var viewModel = LoginViewModel()
    
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
                    // ログインのAPIをたたく
                    Task { @MainActor in
                        await viewModel.loginButtonPressed()
                    }
                } label: {
                    Text("Log in")
                }
                .disabled(isLoginButtonDisable)

            }
            Spacer()
        }
        .alert(viewModel.loginViewErrorInfo.title, isPresented: $viewModel.loginViewErrorInfo.isPresentingError) {
            Button("閉じる", action: {})
        } message: {
            Text(viewModel.loginViewErrorInfo.message)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
