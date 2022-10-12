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
            TwitterAPIService.OAuth2.shared.openLoginPage()
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
