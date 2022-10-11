//
//  Home.swift
//  TwitterAPPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/11.
//

import SwiftUI
import TwitterAPIKit
import AuthenticationServices

class AuthPresentationContextProver: NSObject, ASWebAuthenticationPresentationContextProviding {
    private weak var viewController: UIViewController!

    init(viewController: UIViewController) {
        self.viewController = viewController
        super.init()
    }

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return viewController?.view.window! ?? ASPresentationAnchor()
    }
}

struct Home: View {
    
    @State var client: TwitterAPIClient!
    @State var presentationContextProvider: AuthPresentationContextProver?
    
    var body: some View {
        Button {
            runAuth()
        } label: {
            Text("Log in")
        }

    }
    
    func runAuth() {
        
        client = TwitterAPIClient(.requestOAuth20WithPKCE(.confidentialClient(clientID: TWITTER_API.CLIENT_ID,
                                                                                              clientSecret: TWITTER_API.CLIENT_SECRET)))
        
        let state = "<state_here>" // Rewrite your state

        let clientID = TWITTER_API.CLIENT_ID
        let authorizeURL = client.auth.oauth20.makeOAuth2AuthorizeURL(.init(
            clientID: clientID,
            redirectURI: TWITTER_API.CALLBACKURL,
            state: state,
            codeChallenge: "code challenge",
            codeChallengeMethod: "plain", // OR S256
            scopes: ["tweet.read", "tweet.write", "users.read", "offline.access"]
        ))!

        let session = ASWebAuthenticationSession(url: authorizeURL, callbackURLScheme: TWITTER_API.CALLBACKURL_SCHEME) { url, error in
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
                redirectURI: TWITTER_API.CALLBACKURL,
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

//extension Home: ASWebAuthenticationPresentationContextProviding {
//    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
//        return view.window!
//    }
//}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
