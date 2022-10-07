//
//  TwitterService+Login.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/07.
//

import UIKit

extension TwitterAPIService {
    
    final class Login {
        
        static let shared: Login = .init()
        
        /// 認証後のアクション
        private var successAuthentication: (String) -> Void = {_ in}
        private var failAuthentication: () -> Void = {}
        
        // MARK: - Login
        public func openLoginPage(success: @escaping (String) -> Void = {_ in},
                                  failure: @escaping () -> Void = {}) {
            
            guard let loginUrl = TwitterAPIRequest.Login().buildURLRequest().url else {
                return
            }
            
            successAuthentication = success
            failAuthentication = failure
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleReceivingCallbackURL(_:)),
                                                   name: Notification.Name.receivedCallBackURL,
                                                   object: nil)
            UIApplication.shared.open(loginUrl)
        }
        
        @objc func handleReceivingCallbackURL(_ notification: Notification) {
            NotificationCenter.default.removeObserver(self)
            
            guard let callbackURL = notification.userInfo?[NotificationUserinfoKeys.callbackURL] as? URL,
                  let queryItems = URLComponents(url: callbackURL , resolvingAgainstBaseURL: true)?.queryItems,
                  let loginResponse = TwitterAPIResponse.Login(queryItems: queryItems)
            else {
                failAuthentication()
                return
            }
            successAuthentication(loginResponse.code)
        }
    }
}
