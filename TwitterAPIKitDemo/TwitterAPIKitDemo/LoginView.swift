//
//  LoginView.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: LoginViewModel = .init()
    @State private var code: String = ""
    
    var body: some View {
        
        ZStack {
            Color.twitterBlue
                .ignoresSafeArea()
            
            VStack {
                Image("TwitterMark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Button {
                    Task { @MainActor in
                        try await viewModel.loginButtonPressed { code in
                            self.code = code
                        }
                    }
                } label: {
                    Text("Log in with Twitter")
                        .frame(width: 200, height: 48)
                        .foregroundColor(.twitterBlue)
                        .background(.white)
                        .cornerRadius(24)
                }
                
                Text("code: \(code)")
                
                Button {
                    
                } label: {
                    Text("Get initial token")
                }

                
            }
            .padding(.bottom, 60)
        }
        .onReceive(viewModel.dismiss) { _ in
            dismiss()
        }
        .alert(viewModel.errorWrapper.title,
               isPresented: $viewModel.errorWrapper.isPresentingErrorView) {
            Button("Close", action: {})
        } message: {
            Text(viewModel.errorWrapper.guidance)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
