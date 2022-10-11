//
//  Home.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/11.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        Button {
            TwitterAPIService.Login.shared.openLoginPage()
        } label: {
            Text("Log in")
        }
    }
}
    /*
    func runAuth() {
        
        let session = ASWebAuthenticationSession(url: authorizeURL, callbackURLScheme: TWITTER_API.callbackURLScheme) { url, error in
//            guard let self = self else { return }

            guard let url = url else {
                print(error!)
                return
            }
            print("return url", url)

            let component = URLComponents(url: url, resolvingAgainstBaseURL: false)

            guard let returnedState = component?.queryItems?.first(where: {$0.name == "state"})?.value,
                  let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else {
                print("Invalid return url")
                return
            }
            guard state == returnedState else {
                print("Invalid state", state, returnedState)
                return
            }

            self.client.auth.oauth20.postOAuth2AccessToken(.init(
                code: code,
                clientID: clientID,
                redirectURI: TWITTER_API.callbackURL,
                codeVerifier: "code challenge"
            )).responseObject { response in
                do {
                    let token = try response.result.get()
//                    self.env.oauthToken = nil
//                    self.env.token = .init(clientID: clientID, token: token)
//                    self.env.store()
//                    self.showAlert(title: "Success!", message: nil) {
//                        self.navigationController?.popViewController(animated: true)
//                    }
                    print("stop")
                } catch let error {
//                    self.showAlert(title: "Error", message: error.localizedDescription)
                    print("stop")
                    print(error.localizedDescription)
                }
            }
        }
        
        let presentationContextProvider = AuthPresentationContextProver(viewController: UIHostingController(rootView: self))
        session.presentationContextProvider = presentationContextProvider
        self.presentationContextProvider = presentationContextProvider
        session.prefersEphemeralWebBrowserSession = true
        
        session.start()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/
