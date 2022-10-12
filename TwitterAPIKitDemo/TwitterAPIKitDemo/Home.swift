//
//  Home.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/11.
//

import SwiftUI
import CryptoKit
import CommonCrypto

final class MyCrypto {
    static func sha256(_ string: String) -> String {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))

        let data = string.data(using: .utf8)!
        data.withUnsafeBytes { pointer -> Void in
            CC_SHA256(pointer.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash).base64EncodedString()
    }
}

struct Home: View {
    
    private var codeVerifier: String {
        TWITTER_API.codeVerifier
    }
    
    private var codeChallenge: String {
//            Data(
//                SHA256.hash(data: TWITTER_API.codeChallenge.data(using: .utf8)!)
//            ).base64EncodedString()
        
        MyCrypto.sha256(codeVerifier)
            .replacingOccurrences(of: "=", with: "")
    }
    
    var body: some View {
        Button {
            TwitterAPIService.OAuth2.shared.openLoginPage()
            print(codeVerifier)
            print(codeChallenge)
            print(
                codeChallenge
                    .replacingOccurrences(of: "=", with: "")
//                    .replacingOccurrences(of: "+", with: "-")
//                    .replacingOccurrences(of: "/", with: "_")
            )
        } label: {
            Text("Log in")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
