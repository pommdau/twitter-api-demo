//
//  LoginView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack {
                    TextField("ID", text: $viewModel.id)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                }
                .frame(width: 200)
                Spacer()
                Button {
                    // ログインのAPIをたたく
                    Task { @MainActor in
                        if await viewModel.loginButtonPressed() {
                            // ログインに成功したら画面を閉じる
                            dismiss()
                        }
                    }
                } label: {
                    Text("Log in")
                }
                .disabled(!viewModel.isLoginButtonEnabled)
            }
            Spacer()
        }
        .alert(viewModel.errorWrapper.title,
               isPresented: $viewModel.errorWrapper.isPresentingError) {
            Button("閉じる", action: {})
        } message: {
            Text(viewModel.errorWrapper.message)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
