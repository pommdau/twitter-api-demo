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
    
    @AppStorage("code") var code: String = ""
    
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
                        viewModel.loginButtonPressed()
                    }
                } label: {
                    Text("Log in with Twitter")
                        .frame(width: 200, height: 48)
                        .foregroundColor(.twitterBlue)
                        .background(.white)
                        .cornerRadius(24)
                }
                                
                Button {
                    print(self.code)
                } label: {
                    Text("Get initial token")
                }
                
            }
            .padding(.bottom, 60)
        }
        .onReceive(viewModel.dismiss) { _ in
            dismiss()
        }
        .onReceive(viewModel.codeValueChanged) { code in
            self.code = code
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
