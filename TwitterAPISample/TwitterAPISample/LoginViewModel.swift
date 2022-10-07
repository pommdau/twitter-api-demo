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
        TwitterService.Login.shared.openLoginPage { code in
            print(code)
        } failure: {
            print("error")
        }
    }
}
