//
//  ContentView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
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
        .sheet(isPresented: $isPresentingLoginView) {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
