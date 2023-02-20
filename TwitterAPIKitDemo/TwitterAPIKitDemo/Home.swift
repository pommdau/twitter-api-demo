//
//  Home.swift
//  TwitterAPIKitDemo
//
//  Created by HIROKI IKEUCHI on 2022/10/11.
//

import SwiftUI

struct Home: View {
    
    @State private var isPresentingLoginView = true
        
    var body: some View {        
        Button {
            isPresentingLoginView.toggle()
        } label: {
            Text("Login View")
        }
        .fullScreenCover(isPresented: $isPresentingLoginView, content: {
            LoginView()
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
