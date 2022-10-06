//
//  LoginView.swift
//  TwitterAPISample
//
//  Created by HIROKI IKEUCHI on 2022/10/06.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            Color.twitterBlue
                .ignoresSafeArea()
            
            VStack {
                Image("TwitterMark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                                
                Button {
                    print("login...")
                    dismiss()
                } label: {
                    Text("Log in with Twitter")
                        .frame(width: 200, height: 48)
                        .foregroundColor(.twitterBlue)
                        .background(.white)
                        .cornerRadius(24)
                }
            }
            .padding(.bottom, 60)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
