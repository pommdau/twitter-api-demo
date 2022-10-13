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
                    print("code: \(viewModel.code)")
                    Task {
                        print(await TwitterAPIService.OAuth20.shared.oAuth20 ?? "(nil)")
                    }
                } label: {
                    Text("Print Debug Value")
                        .frame(width: 200, height: 48)
                        .foregroundColor(.twitterBlue)
                        .background(.white)
                        .cornerRadius(24)
                }
                
                Button {
                    Task { @MainActor in
                        try await viewModel.getInitialTokenButtonPressed()
                    }
                } label: {
                    Text("Get initial token")
                        .frame(width: 200, height: 48)
                        .foregroundColor(.twitterBlue)
                        .background(.white)
                        .cornerRadius(24)
                }
                
            }
            .padding(.bottom, 60)
        }
        .onReceive(viewModel.dismiss) { _ in
            dismiss()
        }
        .onReceive(viewModel.codeValueChanged) { _ in
            print("codeが更新されましたよ")
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
