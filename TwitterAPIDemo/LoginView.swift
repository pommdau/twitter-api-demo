//
//  LoginView.swift
//  TwitterAPIDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/21.
//

import SwiftUI

struct LoginView: View {
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var isPresentingError = false
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack {
                    TextField("ID", text: $id)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                }
                .frame(width: 200)
                Spacer()
                Button {
//                    isPresentingError.toggle()
                    // ログインのAPIをたたく
                    
                    
                    
                } label: {
                    Text("Log in")
                }

            }
            Spacer()
        }
        .alert("ログインエラー", isPresented: $isPresentingError) {
            Button("閉じる", action: {})
        } message: {
            Text("IDまたはパスワードが正しくありません。")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
