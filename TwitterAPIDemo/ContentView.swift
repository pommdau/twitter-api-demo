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
        if isPresentingLoginView {
            LoginView(isPresentingLoginView: $isPresentingLoginView)
        } else {
            Text("next Login...")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
