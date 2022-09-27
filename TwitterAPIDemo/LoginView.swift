//
//  LoginView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: LoginViewModel<AuthService> = .init()
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack {
                    TextField("ID", text: $viewModel.id)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $viewModel.password)
                        .textInputAutocapitalization(.never)
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
        .onReceive(viewModel.dismiss) { _ in
            dismiss()
        }
        .alert(viewModel.errorWrapper.authServiceError.title,
               isPresented: $viewModel.errorWrapper.isPresentingError) {
            Button("閉じる", action: {})
        } message: {
            Text(viewModel.errorWrapper.authServiceError.guidance)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
