//
//  ContentView.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/05.
//

import SwiftUI

struct ContentView: View {
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
