//
//  LoginView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isPresentingLoginView: Bool  // TODO: viewModelに渡して、viewModel.loginButtonPressed()の中で値を更新したい。
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
                        await viewModel.loginButtonPressed()
                    }
                } label: {
                    Text("Log in")
                }
                .disabled(!viewModel.isLoginButtonEnabled)
            }
            Spacer()
        }
        .alert(viewModel.errorInfo.title, isPresented: $viewModel.errorInfo.isPresentingError) {
            Button("閉じる", action: {})
        } message: {
            Text(viewModel.errorInfo.message)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isPresentingLoginView: .constant(true))
    }
}
