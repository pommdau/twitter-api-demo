//
//  LoginView.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/12.
//

import SwiftUI
import TwitterAPIKit

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
                    return;
                    
                    IKEHTwitterAPIClient.shared.client.auth.oauth20.postOAuth2AccessToken(.init(
                        code: viewModel.code,
                        clientID: TWITTER_API.clientID,
                        redirectURI: TWITTER_API.callbackURL,
                        codeVerifier: TWITTER_API.codeVerifier
                    )).responseObject { response in
                        do {
                            let token = try response.result.get()
                            print("Stop")
//                            self.env.oauthToken = nil
//                            self.env.token = .init(clientID: clientID, token: token)
//                            self.env.store()
//                            self.showAlert(title: "Success!", message: nil) {
//                                self.navigationController?.popViewController(animated: true)
//                            }
                        } catch let error {
//                            self.showAlert(title: "Error", message: error.localizedDescription)
                            print(error.localizedDescription)
                            print("Stop")
                        }
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
            print("code \(viewModel.code)")
            Task {
//                try await viewModel.getInitialTokenButtonPressed()
            }
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
