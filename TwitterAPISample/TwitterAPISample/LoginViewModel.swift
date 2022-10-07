//
//  LoginViewModel.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/06.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    let dismiss: PassthroughSubject<Void, Never> = .init()
    
    func loginButtonPressed() async {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceivingCallbackURL(_:)),
//                                               name: Notification.Name.receivedCallBackURL,
                                               name: Notification.Name("CallbackNotification"),
                                               object: nil)
        
        TwitterService.Login.shared.openLoginPage { hoge in
            print(hoge)
        } failure: {
            print("error")
        }

    }
    
    @objc func handleReceivingCallbackURL(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self)
        print("Get Callbak")
//        guard let callbackURL = notification.userInfo?[NotificationUserinfoKeys.callbackURL] as? URL,
//              let queryItems = URLComponents(url: callbackURL , resolvingAgainstBaseURL: true)?.queryItems,
//              let callbackUrlInfo = LoginResponse(queryItems: queryItems)
//        else {
//            failAuthentication()
//            return
//        }
//        successAuthentication(callbackUrlInfo.code)
    }
}
